import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode? state;

  ThemeManager({this.state}) {
    _initialize();
  }

  void _initialize() {
    SharedPreferences.getInstance().then((value) {
      final int? themeMode = value.getInt('themeMode');
      if (themeMode == 1) {
        state = ThemeMode.light;
      } else if (themeMode == 2) {
        state = ThemeMode.dark;
      } else if (themeMode == 3) {
        state = ThemeMode.system;
      }
    });
  }

  void switchTo(ThemeMode? arg) async {
    state = arg;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int value = 0;
    if (state == ThemeMode.light) {
      value = 1;
    } else if (state == ThemeMode.dark) {
      value = 2;
    } else if (state == ThemeMode.system) {
      value = 3;
    }
    pref.setInt('themeMode', value);
    notifyListeners();
  }
}
