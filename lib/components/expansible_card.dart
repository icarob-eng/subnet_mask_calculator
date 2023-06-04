import 'package:flutter/material.dart';

class ExpansibleCard extends StatefulWidget {
  final bool initialilIsExpanded;

  final String title;
  final List<Widget> children;

  const ExpansibleCard(
      {super.key,
      required this.title,
      required this.children,
      this.initialilIsExpanded = false});

  @override
  State<ExpansibleCard> createState() => _ExpansibleCardState();
}

class _ExpansibleCardState extends State<ExpansibleCard>
    with TickerProviderStateMixin {
  late bool _isExpanded;

  late final AnimationController _controller;
  late final AnimationController _turnController;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initialilIsExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _turnController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        upperBound: 0.5);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _turnController.dispose();
  }

  @override
  Widget build(BuildContext contex) {
    return GestureDetector(
      onTap: () {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          _controller.forward();
          _turnController.forward();
        } else {
          _controller.reverse();
          _turnController.reverse();
        }
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_turnController),
                    child: const Icon(Icons.keyboard_arrow_down_outlined),
                  )
                ],
              ),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Column(children: widget.children),
            ),
          ],
        ),
      ),
    );
  }
}
