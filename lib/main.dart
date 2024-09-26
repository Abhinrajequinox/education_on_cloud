import 'package:education_on_cloud/Controller/AuthController/apptraslation.dart';
import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/chooselanguagescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    final LanguageController languageController = Get.find<LanguageController>();

    return Obx(() { 
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        title: 'Education On Cloud',
        theme: languageController.currentTheme.value,
        debugShowCheckedModeBanner: false,
        home: const ChooseLanguageScreen(),
      );
    });
  }
}
