import 'dart:developer';
import 'package:education_on_cloud/Theme/appthemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  // Observable for theme

  Future<void> changeLanguage(String code, String country)async {
    var locale = Locale(code, country);
    currentLocale.value = locale; 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);
    await prefs.setString('countryCode', country);// Update the locale
    Get.updateLocale(locale);
  }
   Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode') ?? 'en';
    String? countryCode = prefs.getString('countryCode') ?? 'US';
    currentLocale.value = Locale(languageCode, countryCode);
  }

    final GoogleTranslator translator = GoogleTranslator();

  // Function to fetch the language from SharedPreferences
  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode') ?? 'en';  // Default to English
    return languageCode;
  }

  // Function to translate text based on the selected language
  Future<String> changeText(String text) async {
    String languageCode = await getSelectedLanguage();  // Fetch language from SharedPreferences
    var translated = await translator.translate(text, to: languageCode);
    return translated.text;
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
