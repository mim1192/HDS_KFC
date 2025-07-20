import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme Controller to manage theme state
class ThemeController extends GetxController {
  var primaryColor = Color(0xff948e91).obs;
  var secondaryColor = Color(0xff000000).obs;
  var backgroundColor = Color(0xFF644600).obs;
  var textColor = Color(0xFF002379).obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // Method to update the theme colors
  updateTheme(Color primary, Color secondary, Color background, Color text) {
    primaryColor.value = primary;
    secondaryColor.value = secondary;
    backgroundColor.value = background;
    textColor.value = text;
    _saveTheme(
      primary,
      secondary,
      background,
      text,
    ); // Save theme changes to SharedPreferences
  }

  // Save theme colors to SharedPreferences
  _saveTheme(
    Color primary,
    Color secondary,
    Color background,
    Color text,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', primary.value);
    prefs.setInt('secondaryColor', secondary.value);
    prefs.setInt('backgroundColor', background.value);
    prefs.setInt('textColor', text.value);
  }

  // Load saved theme colors from SharedPreferences
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primaryColor.value = Color(
      prefs.getInt('primaryColor') ?? Color(0xff36318c).value,
    );
    secondaryColor.value = Color(
      prefs.getInt('secondaryColor') ?? Color(0xff58655f).value,
    );
    backgroundColor.value = Color(
      prefs.getInt('backgroundColor') ?? Color(0xFF644600).value,
    );
    textColor.value = Color(
      prefs.getInt('textColor') ?? Color(0xFF002379).value,
    );
  }
}
