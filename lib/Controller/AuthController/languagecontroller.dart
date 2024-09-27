import 'dart:developer';
import 'package:education_on_cloud/Theme/appthemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  // Observable for theme

  void changeLanguage(String code, String country) {
    var locale = Locale(code, country);
    currentLocale.value = locale; // Update the locale
    Get.updateLocale(locale);
  }

  Rx<ThemeData> currentTheme = AppThemes.lightTheme.obs;
  RxString currentMode = 'Light Mode'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs(); // Load theme when the controller is initialized
  }

  void changeMode(String mode) async {
    log('Changing mode to: $mode');
    currentMode.value = mode;
    switch (mode) {
      case 'Light Mode':
        currentTheme.value = AppThemes.lightTheme;
        break;
      case 'Dark Mode':
        currentTheme.value = AppThemes.darkTheme;
        break;
      case 'Summer Mode':
        currentTheme.value = AppThemes.summerTheme;
        break;
      case 'Winter Mode':
        currentTheme.value = AppThemes.winterTheme;
        break;
      case 'Autumn Mode':
        currentTheme.value = AppThemes.autumnTheme;
        break;
      case 'Rainy Mode':
        currentTheme.value = AppThemes.rainyTheme;
        break;
    }
    Get.changeTheme(currentTheme.value);
    await _saveThemeToPrefs(
        mode); // Save the selected mode to SharedPreferences
  }

  // Load theme from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedMode = prefs.getString('selectedMode');
    if (savedMode != null) {
      changeMode(savedMode); // Apply saved mode
    }
  }

  // Save the selected theme mode to SharedPreferences
  Future<void> _saveThemeToPrefs(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMode', mode);
  }

}
