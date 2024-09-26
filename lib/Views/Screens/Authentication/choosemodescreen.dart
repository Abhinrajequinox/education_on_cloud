import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Auth/languageselectwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

final LanguageController languageController = Get.find<LanguageController>();
final LanguageSelectWidget languageSelectWidget = LanguageSelectWidget();
final List<Map<String, String>> _modes = [
  {"mode": "Light Mode"},
  {"mode": "Dark Mode"},
  {"mode": "Summer Mode"},
  {"mode": "Winter Mode"},
  {"mode": "Autumn Mode"},
  {"mode": "Rainy Mode"},
];

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: languageController.currentTheme.value.scaffoldBackgroundColor,
        body: _body(context),
      ),
    );
  }
}

Widget _body(BuildContext context) {
  // Get screen width and height
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1, bottom: 16), // 10% of screen height
          child: CustomText(
            text: 'Select Your Moods',
            textStyle: GoogleFonts.inter(
              fontSize: screenWidth * 0.045, // 4.5% of screen width
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(24, 32, 53, 1),
            ),
          ),
        ),
        CustomText(
          text: 'Choose as many moods as you like',
          textStyle: GoogleFonts.inter(
            fontSize: screenWidth * 0.045, // 4.5% of screen width
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30),
        
        // Display mood list
        languageSelectWidget.modeList(_modes,context),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomAuthButton(
              width: screenWidth * 0.35, // 35% of screen width
              text: 'Next',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}
