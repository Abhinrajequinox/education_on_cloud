import 'dart:developer';
import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelectWidget {
  final LanguageController languageController = Get.find<LanguageController>();

  Widget languageList(List<Map<String, String>> languages, BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.6, // 50% of the screen height
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          bool isSelected =
              languageController.currentLocale.value.languageCode ==
                  language["code"];
          return GestureDetector(
            onTap: () {
              languageController.changeLanguage(
                  language["code"]!, language["country"]!);
              log(languageController.currentLocale.value.toString());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // 1% of screen height
              child: Container(
                height: screenHeight * 0.045, // 5% of screen height
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02), // 2% of screen height
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? const Color.fromARGB(255, 9, 97, 245)
                        : Colors.grey,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenHeight * 0.02), // 2% of screen height
                      child: Container(
                        width: screenHeight * 0.025, // 2.5% of screen height
                        height: screenHeight * 0.025, // 2.5% of screen height
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.005), // 0.5% of screen height
                          child: CircleAvatar(
                            radius: screenHeight * 0.0125, // 1.25% of screen height
                            backgroundColor: isSelected
                                ? const Color.fromARGB(255, 9, 97, 245)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      language["language"]!,
                      style: GoogleFonts.lato(fontSize: screenHeight * 0.02), // 2% of screen height
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
            bool isSelected = languageController.currentMode.value == mode["mode"];
            return GestureDetector(
              onTap: () {
                languageController.changeMode(mode["mode"]!); // Change the mode
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // 1% of screen height
                child: Container(
                  height: screenHeight * 0.05, // 5% of screen height
                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02), // 2% of screen height
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? const Color.fromARGB(255, 9, 97, 245)
                          : Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenHeight * 0.02), // 2% of screen height
                        child: Container(
                          width: screenHeight * 0.025, // 2.5% of screen height
                          height: screenHeight * 0.025, // 2.5% of screen height
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 0.005), // 0.5% of screen height
                            child: CircleAvatar(
                              radius: screenHeight * 0.0125, // 1.25% of screen height
                              backgroundColor: isSelected
                                  ? const Color.fromARGB(255, 9, 97, 245)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        mode["mode"]!,
                        style: GoogleFonts.lato(fontSize: screenHeight * 0.02), // 2% of screen height
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
