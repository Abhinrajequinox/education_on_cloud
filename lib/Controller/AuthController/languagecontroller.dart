import 'dart:async';
import 'dart:developer';
import 'package:education_on_cloud/Controller/AuthController/apptraslation.dart';
import 'package:education_on_cloud/Theme/appthemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  final LanguageTranslations languageTranslations = LanguageTranslations();
  var currentLocale = const Locale('en', 'US').obs;
  //  var translatedTexts = <String, String?>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
    _loadThemeFromPrefs();
  }

  final StreamController<Locale> _languageController =
      StreamController<Locale>.broadcast();
  Stream<Locale> get languageStream => _languageController.stream;

  Future<void> changeLanguage(String code, String country) async {
    var locale = Locale(code, country);
    currentLocale.value = locale;
    _languageController.add(locale);
    log('the changed language code is ${currentLocale.value} ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);
    await prefs.setString('countryCode', country);
    String? storedLang = prefs.getString('languageCode');
    log('Stored language code: $storedLang');
    Get.updateLocale(locale);
    Get.forceAppUpdate();
  }

  Future<String> translateApiText(String apiText) async {
    log('the passed language code is ${currentLocale.value} ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedLang = prefs.getString('languageCode');
    log('Stored language code: $storedLang');

    String translatedText =
        await languageTranslations.translateDynamicText(apiText, storedLang!);
    return translatedText;
  }

  Future<String> getCurrentLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedLang = prefs.getString('languageCode');
    return storedLang!;
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode') ?? 'en';
    String? countryCode = prefs.getString('countryCode') ?? 'US';
    currentLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(Locale(languageCode, countryCode));
  }

  Rx<ThemeData> currentTheme = AppThemes.lightTheme.obs;
  RxString currentMode = 'Light Mode'.obs;

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
