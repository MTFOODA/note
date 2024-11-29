import 'package:flutter/material.dart';
import 'package:note_app/shared/sp.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    _isDarkMode = CacheHelper.getData('isDarkMode') ?? false;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    CacheHelper.saveData('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
