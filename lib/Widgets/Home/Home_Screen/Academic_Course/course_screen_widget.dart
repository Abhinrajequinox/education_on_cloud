import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/course_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/theory_chapters_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CourseScreenWidget {
  final CourseScreenController courseScreenController =
      CourseScreenController();

  Widget titleAndBackButton(
      BuildContext context, double screenWidth, String titleOfCourse) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ImageIcon(
                  AssetImage('lib/Assets/Icons/arrow-circle-left.png'),
                  size: 30),
            ),
            SizedBox(width: screenWidth * .03),
            SizedBox(
              width: screenWidth * .7,
              child: CustomText(
                text: titleOfCourse,
                maxline: 2,
                textalign: TextAlign.start,
                textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              CustomText(
                  text: 'Select Your Subject',
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: primarycolour,
                  )),
            ],
          )
        ],
      ),
    );
  }

  String getLanguageName(String localeCode) {
    var languageCode = localeCode.split('_')[0]; // Extract the language part

    // Mapping of language codes to full language names
    Map<String, String> languages = {
      'en': 'English',
      'hi': 'Hindi',
      'ta': 'Tamil',
      'kn': 'Kannada',
      'te': 'Telugu',
      'ml': 'Malayalam',
      'bn': 'Bengali',
      'gu': 'Gujarati',
      'mr': 'Marathi',
      // Add more languages as needed!
    };

    // Return the full language name, or 'Unknown' if not found
    return languages[languageCode] ?? 'Unknown';
  }

  Widget listOfCourses(
      {required List<CourseModel> courses,
      required double screenHeight,
      required double screenWidth,
      required String titleOfCourse}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var course = courses[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Card(
            child: Container(
              // width: screenWidth * 1,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(0, 78, 255, 1), width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: const Color.fromRGBO(22, 93, 255, 0.1)),
              height: screenHeight * .15,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: SizedBox(
                      width: screenWidth * .3,
                      height: screenHeight * 0.15,
                      child: Image.network(
                        "https://educationoncloud.in/admin/html/ajax/course_img/${course.img}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      SizedBox(
                        width:
                            screenWidth * .5, // Or dynamically calculate width
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomText(
                                maxline: 1,
                                text: titleOfCourse,
                                textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: const Color.fromRGBO(0, 56, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * .006,
                      ),
                      SizedBox(
                        width: screenWidth * .5,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomText(
                                text: course.courseName,
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          courseDetialsButton(
                            index: index,
                            buttonName: 'Course Details',
                            onTap: () async {
                              // log(course.id);
                              courseScreenController
                                  .changeColorOfCourseDetailButton(index);
                              var languageCode =
                                  languageController.currentLocale.value;
                              //  log('the current language code is $languageCode');
                              var languageName =
                                  getLanguageName(languageCode.toString());
                              // log('the course id is ${course.id}');
                              List<ChapterModel> _chapters =
                                  await academicCourseServices
                                      .fetchCourseChapters(
                                          courseId: course.id,
                                          language: languageName);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TheoryChaptersScreen(
                                        titleOfChapter: course.courseName,
                                        chapters: _chapters,courseId:course.id,languageName:languageName),
                                  ));
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                courseScreenController
                                    .changeColorOfCourseDetailButton(100);
                              });
                            },
                          ),
                          SizedBox(
                            width: screenWidth * .02,
                          ),
                          addClassButton(
                            index: index,
                            buttonName: 'Add to Class',
                            onTap: () {
                              courseScreenController
                                  .changecolorOfAddToClassButtonButton(index);

                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                courseScreenController
                                    .changecolorOfAddToClassButtonButton(100);
                              });
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: courses.length,
    );
  }

  Widget courseDetialsButton(
      {required String buttonName,
      required void Function()? onTap,
      required int index}) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              gradient: courseScreenController
                          .colorOfCourseDetailButton.value ==
                      index
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(0, 56, 255, 1),
                      Color.fromRGBO(0, 224, 255, 1)
                    ])
                  : const LinearGradient(colors: [Colors.white, Colors.white]),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: courseScreenController.colorOfCourseDetailButton.value ==
                      index
                  ? const Border.fromBorderSide(BorderSide.none)
                  : Border.all()),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: buttonName,
                  textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: courseScreenController
                                  .colorOfCourseDetailButton.value ==
                              index
                          ? Colors.white
                          : Colors.black),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color:
                      courseScreenController.colorOfCourseDetailButton.value ==
                              index
                          ? Colors.white
                          : const Color.fromRGBO(9, 97, 245, 1),
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addClassButton(
      {required String buttonName,
      required void Function()? onTap,
      required int index}) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              gradient: courseScreenController.colorOfAddToClassButton.value ==
                      index
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(0, 56, 255, 1),
                      Color.fromRGBO(0, 224, 255, 1)
                    ])
                  : const LinearGradient(colors: [Colors.white, Colors.white]),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border:
                  courseScreenController.colorOfAddToClassButton.value == index
                      ? const Border.fromBorderSide(BorderSide.none)
                      : Border.all()),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: buttonName,
                  textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: courseScreenController
                                  .colorOfAddToClassButton.value ==
                              index
                          ? Colors.white
                          : Colors.black),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: courseScreenController.colorOfAddToClassButton.value ==
                          index
                      ? Colors.white
                      : const Color.fromRGBO(9, 97, 245, 1),
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
