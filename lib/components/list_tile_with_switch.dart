import 'package:flutter/material.dart';

class ListTitleWithSwitch extends StatefulWidget {
  final Widget title;
  final bool switchInitialValue;
  final void Function(bool)? onSwitchChange;

  const ListTitleWithSwitch(
      {super.key,
      required this.title,
      required this.switchInitialValue,
      this.onSwitchChange});

  @override
  State<ListTitleWithSwitch> createState() => _LisTitleWithSwitchState();
}

class _LisTitleWithSwitchState extends State<ListTitleWithSwitch> {
  late bool switchValue;

  void Function(bool)? function() {
    if (widget.onSwitchChange != null) {
      return (bool value) {
        setState(() {
          switchValue = !switchValue;
        });
        widget.onSwitchChange!(value);
      };
    }
    return null;
  }

  @override
  void initState() {
    switchValue = widget.switchInitialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      trailing: Switch(
        value: switchValue,
        onChanged: function(),
      ),
    );
  }
}
