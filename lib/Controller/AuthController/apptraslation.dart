import 'dart:developer';

import 'package:translator/translator.dart';

class LanguageTranslations {
  final GoogleTranslator translator = GoogleTranslator();
  final Map<String, String> _dynamicTranslations = {};

  Future<String> translateDynamicText(String text, String languageCode) async {
     var translation = await translator.translate(text, to: languageCode);
      _dynamicTranslations[text] = translation.text;
      log(translation.text);
      log(languageCode);
      return translation.text;
  }
}
