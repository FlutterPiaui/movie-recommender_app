import 'package:flutter/material.dart';
import 'theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final ThemePreferences _preferences = ThemePreferences();
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadFromPrefs();
  }

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    _isDarkTheme = await _preferences.getTheme();
    notifyListeners();
  }

  _saveToPrefs() async {
    await _preferences.setTheme(_isDarkTheme);
  }
}
