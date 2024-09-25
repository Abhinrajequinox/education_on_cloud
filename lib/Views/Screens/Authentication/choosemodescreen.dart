import 'package:education_on_cloud/Controller/Auth/languagecontroller.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Auth/languageselectwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

final LanguageController languageController = Get.find<LanguageController>();
final LanguageSelectWidget languageSelectWidget = LanguageSelectWidget();
final List<Map<String, String>> _modes = [
  {
    "mode": "Light Mode",
  },
  {
    "mode": "Dark Mode",
  },
  {
    "mode": "Summer Mode",
  },
  {
    "mode": "Winter Mode",
  },
  {
    "mode": "Autumn Mood",
  },
  {
    "mode": "Rainy Mood",
  },
];

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }
}

Widget _body(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(top: 72.01, bottom: 16),
            child: CustomText(
                text: 'Select Your Moods',
                textStyle: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(24, 32, 53, 1)))),
        CustomText(text: 'Choose as many moods as you like',textStyle: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w500),),const SizedBox(height: 30,),
        languageSelectWidget.modeList(_modes),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [CustomAuthButton(text: 'Next',onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const ChooseModeScreen(),));
      },)])
      ]));
}
