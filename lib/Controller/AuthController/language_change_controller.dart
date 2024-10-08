// import 'dart:ui';

// import 'package:get/get.dart';
// import 'package:translator/translator.dart';
// import 'package:get_storage/get_storage.dart';

// class LocalizationController extends GetxController {
//   final storage = GetStorage();
//   GoogleTranslator translator = GoogleTranslator();

//   RxString currentLanguage = 'en'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     currentLanguage.value = getSavedLocale(); // Set saved language on app start
//   }

//   void changeLocale(String langCode) {
//     currentLanguage.value = langCode;
//     Get.updateLocale(Locale(langCode));
//     storage.write('language', langCode); // Persist selected language
//   }

//   String getSavedLocale() {
//     String? savedLang = storage.read('language');
//     return savedLang ?? 'en'; // Default to English if not set
//   }

//   // Translate a given text dynamically
//   Future<String> translateText(String text) async {
//     if (currentLanguage.value == 'en') {
//       return text; // If English, no need to translate
//     }
//     final translation = await translator.translate(text, to: currentLanguage.value);
//     return translation.text;
//   }
// }
