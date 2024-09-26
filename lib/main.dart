import 'package:education_on_cloud/Controller/Auth/apptraslation.dart';
import 'package:education_on_cloud/Controller/Auth/languagecontroller.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/chooselanguagescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  // Initialize LanguageController as a singleton
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the LanguageController
    final LanguageController languageController = Get.find<LanguageController>();

    return Obx(() { 
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        title: 'Education On Cloud',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primarycolour),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const ChooseLanguageScreen(),
      );
    });
  }
}
