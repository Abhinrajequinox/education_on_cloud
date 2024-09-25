import 'package:education_on_cloud/Theme/appthemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {

  var currentLocale = const Locale('en', 'US').obs;

  var currentMode = 'Light Mode'.obs; 

  var currentTheme = AppThemes.lightTheme.obs;  // Observable for theme

  void changeLanguage(String code, String country) {
    var locale = Locale(code, country);
    currentLocale.value = locale; // Update the locale
    Get.updateLocale(locale);
  }

  void changeMode(String mode) {
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
      case 'Autumn Mood':
        currentTheme.value = AppThemes.autumnTheme;
        break;
      case 'Rainy Mood':
        currentTheme.value = AppThemes.rainyTheme;
        break;
    }
    // Call Get.changeTheme to apply the new theme
    Get.changeTheme(currentTheme.value);
  }
}

