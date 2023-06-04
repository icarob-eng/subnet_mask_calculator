import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode? state = ThemeMode.system;

  void switchTo(ThemeMode? arg) {
    state = arg;
    notifyListeners();
  }
}
