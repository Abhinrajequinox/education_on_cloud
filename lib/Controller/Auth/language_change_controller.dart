import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageChangeController {
  GoogleTranslator translator= GoogleTranslator();
  String? out;
final lang=TextEditingController();

  void translations(String langCode){

    translator.translate(lang.text);
    
  }
}