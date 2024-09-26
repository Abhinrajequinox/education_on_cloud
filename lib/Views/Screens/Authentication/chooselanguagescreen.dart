import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Auth/languageselectwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

final LanguageController languageController = Get.find<LanguageController>();
final LanguageSelectWidget languageSelectWidget = LanguageSelectWidget();
final List<Map<String, String>> _languages = [
  {"code": "en", "country": "US", "language": "English"},
  {"code": "hi", "country": "IN", "language": "हिंदी"},
  {"code": "ta", "country": "IN", "language": "தமிழ்"},
  {"code": "kn", "country": "IN", "language": "ಕನ್ನಡ"},
  {"code": "te", "country": "IN", "language": "తెలుగు"},
  {"code": "ml", "country": "IN", "language": "മലയാളം"},
  {"code": "bn", "country": "IN", "language": "বাংলা"},
  {"code": "gu", "country": "IN", "language": "ગુજરાતી"},
  {"code": "mr", "country": "IN", "language": "मराठी"},
];

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
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
            text: 'Select Preferred Language',
            textStyle: GoogleFonts.inter(
              fontSize: screenWidth * 0.045, // 4.5% of screen width
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(24, 32, 53, 1),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.07, // 7% of screen width
                height: screenHeight * 0.04, // 4% of screen height
                child: Image.asset('lib/Assets/indianflag.png'),
              ),
              CustomText(
                text: 'INDIA',
                textStyle: GoogleFonts.lato(
                  fontSize: screenWidth * 0.045, // 4.5% of screen width
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        languageSelectWidget.languageList(_languages,context),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomAuthButton(
              width: screenWidth * 0.35, // 35% of screen width
              text: languageController.currentLocale.value.languageCode == "en"
                  ? 'Start'
                  : 'Next',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseModeScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ],
    ),
  );
}
