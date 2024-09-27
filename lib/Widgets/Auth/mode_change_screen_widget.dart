import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ModeChangeScreenWidget {

  Widget selectModeText(double screenHeight, screenWidth) {
    return Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.1, bottom: 16), // 10% of screen height
        child: CustomText(
            text: 'Select Your Moods',
            textStyle: GoogleFonts.inter(
                fontSize: screenWidth * 0.045, // 4.5% of screen width
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(24, 32, 53, 1))));
  }

  Widget chooseManyModeText(double screenWidth) {
    return CustomText(
        text: 'Choose as many moods as you like',
        textStyle: GoogleFonts.inter(
            fontSize: screenWidth * 0.045, // 4.5% of screen width
            fontWeight: FontWeight.w500));
  }

  Widget modeList(List<Map<String, String>> modes, BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
        height: screenHeight * 0.5, // 50% of the screen height
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: modes.length,
            itemBuilder: (context, index) {
              final mode = modes[index];
              return Obx(() {
                bool isSelected =
                    languageController.currentMode.value == mode["mode"];
                return GestureDetector(
                    onTap: () {
                      languageController
                          .changeMode(mode["mode"]!); // Change the mode
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                screenHeight * 0.01), // 1% of screen height
                        child: Container(
                            height: screenHeight * 0.05, // 5% of screen height
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenHeight * 0.02), // 2% of screen height
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isSelected
                                        ? const Color.fromARGB(255, 9, 97, 245)
                                        : Colors.grey,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: screenHeight *
                                              0.02), // 2% of screen height
                                      child: Container(
                                          width: screenHeight *
                                              0.025, // 2.5% of screen height
                                          height: screenHeight *
                                              0.025, // 2.5% of screen height
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1)),
                                          child: Padding(
                                              padding: EdgeInsets.all(screenHeight *
                                                  0.005), // 0.5% of screen height
                                              child: CircleAvatar(
                                                  radius: screenHeight *
                                                      0.0125, // 1.25% of screen height
                                                  backgroundColor: isSelected
                                                      ? const Color.fromARGB(
                                                          255, 9, 97, 245)
                                                      : Colors.transparent)))),
                                  Text(mode["mode"]!,
                                      style: GoogleFonts.lato(
                                          fontSize: screenHeight *
                                              0.02) // 2% of screen height
                                      )
                                ]))));
              });
            }));
  }

  Widget nextButton(double screenWidth, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomAuthButton(
          width: screenWidth * 0.35, // 35% of screen width
          text: 'Next',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          })
    ]);
  }
}
