import 'package:education_on_cloud/Theme/appthemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {

  var currentLocale = const Locale('en', 'US').obs;

   // Observable for theme

  void changeLanguage(String code, String country) {
    var locale = Locale(code, country);
    currentLocale.value = locale; // Update the locale
    Get.updateLocale(locale);
  }


var currentMode = 'Light Mode'.obs; 

  Rx<ThemeData> currentTheme = AppThemes.lightTheme.obs; 

  
  void changeMode(String mode) {
    print('Changing mode to: $mode');
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
    }print('Changing mode to: $mode');
    Get.changeTheme(currentTheme.value);
  }

}

