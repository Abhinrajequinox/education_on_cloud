import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Auth/mode_change_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

ModeChangeScreenWidget modeChangeScreenWidget = ModeChangeScreenWidget();
final LanguageController languageController = Get.find<LanguageController>();

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor:
            languageController.currentTheme.value.scaffoldBackgroundColor,
        body: _body(context)));
  }
}

Widget _body(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Select mode text
        modeChangeScreenWidget.selectModeText(screenHeight, screenWidth),
        // Choose many mode text
        modeChangeScreenWidget.chooseManyModeText(screenWidth),
        const SizedBox(height: 30),
        // Display mood list
        modeChangeScreenWidget.modeList(modes, context),
        // next button
        modeChangeScreenWidget.nextButton(screenWidth, context)
      ]));
}
