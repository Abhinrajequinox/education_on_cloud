import 'dart:developer';
import 'package:education_on_cloud/Controller/Auth/languagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelectWidget {
  final LanguageController languageController = Get.find<LanguageController>();

  Widget languageList(List<Map<String, String>> languages) {
    return SizedBox(
      height: 500,
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? const Color.fromARGB(255, 9, 97, 245)
                          : Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: isSelected
                                ? const Color.fromARGB(255, 9, 97, 245)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      language["language"]!,
                      style: GoogleFonts.lato(fontSize: 16),
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

  Widget modeList(List<Map<String, String>> modes) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: modes.length,
        itemBuilder: (context, index) {
          final mode = modes[index];
          bool isSelected =
              languageController.currentMode.value == mode["mode"];
          return GestureDetector(
            onTap: () {
              languageController.changeMode(mode["mode"]!);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: isSelected
                                ? const Color.fromARGB(255, 9, 97, 245)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      mode["mode"]!,
                      style: GoogleFonts.lato(fontSize: 16),
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
}
