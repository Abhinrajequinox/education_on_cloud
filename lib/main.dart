import 'package:education_on_cloud/Controller/AuthController/apptraslation.dart';
import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/NotificationServices/notification_services.dart';
import 'package:education_on_cloud/Views/Pages/auth_check.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_category_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationServices().initNotification();
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController =
        Get.find<LanguageController>();
    return Obx(() {
      return GetMaterialApp(
        // translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        title: 'Education On Cloud',
        theme: languageController.currentTheme.value,
        debugShowCheckedModeBanner: false,
        home: const AuthCheckPage(),
      );
    });
  }
}
