import 'package:flutter/material.dart';

class ExpansibleCard extends StatefulWidget {
  final bool isExpanded;
  final String title;
  final List<Widget> children;

  const ExpansibleCard({
    Key? key,
    required this.title,
    required this.children,
    this.isExpanded = false,
  }) : super(key: key);

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
    _isExpanded = widget.isExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _turnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      upperBound: 0.5,
    );
    if (_isExpanded) {
      _controller.value = 1.0;
      _turnController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _turnController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ExpansibleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      _toggleExpansion();
    }
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
        _turnController.forward();
      } else {
        _controller.reverse();
        _turnController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_turnController),
                    child: const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
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
