import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  MaterialColor _primaryColor = Colors.blue;
  bool _isDarkMode = false;

  MaterialColor get primaryColor => _primaryColor;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadPreferences();
  }

  void updatePrimaryColor(MaterialColor newColor) async {
    _primaryColor = newColor;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeColor', newColor.value.toString());
  }

  void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? colorString = prefs.getString('themeColor');
    bool? darkMode = prefs.getBool('isDarkMode');

    if (colorString != null) {
      int colorValue = int.tryParse(colorString) ?? Colors.blue.value;
      _primaryColor = _materialColors.firstWhere(
        (color) => color.value == colorValue,
        orElse: () => Colors.blue,
      );
    }

    _isDarkMode = darkMode ?? false;
    notifyListeners();
  }

  List<MaterialColor> get _materialColors => [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
}
