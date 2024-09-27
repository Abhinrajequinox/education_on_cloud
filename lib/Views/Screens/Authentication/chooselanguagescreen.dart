import 'package:education_on_cloud/Widgets/Auth/languageselectwidget.dart';
import 'package:flutter/material.dart';


class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

final LanguageSelectWidget languageSelectWidget = LanguageSelectWidget();


class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }
}

Widget _body(BuildContext context) {
  
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // prefered language text
        languageSelectWidget.preferedlanguageText(screenWidth, screenHeight),
        // indian flag and text session
        languageSelectWidget.indianFlagSession(screenWidth, screenHeight),
        // List of the languages in dropdown
        languageSelectWidget.languageList(context),
        // Next button
        languageSelectWidget.startButton(context, screenWidth)
      ]));
}
