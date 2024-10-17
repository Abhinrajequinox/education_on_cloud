import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/course_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Theory/theory_chapters_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
                        fit: BoxFit.cover,errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(
                            Icons
                                .school_outlined, // Fallback icon (you can use any icon or widget here)
                            size: 40, // Adjust the size if needed
                            color: Colors.white, // Icon color
                          );
                        },
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
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TheoryChaptersScreen(
                                        titleOfChapter: course.courseName,
                                        courseId:course.id,languageName:languageName),
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


// Create a new widget for shimmer effect
Widget shimmerOfListOfCourses({required double height, required double width}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Shimmer for Title and Back Button
        Container(
          margin: EdgeInsets.symmetric(vertical: height * 0.02),
          child: Row(
            children: [
              // Shimmer effect for back button icon
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: const SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(Icons.arrow_back), // Placeholder icon
                ),
              ),
              SizedBox(width: width * .03),
              // Shimmer effect for title
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: width * 0.7,
                  height: 20, // Adjust height as necessary
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        // Shimmer for 'Select Your Subject' Text
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.white,
          child: Container(
            width: width * 0.6,
            height: 15, // Adjust height as necessary
            margin: EdgeInsets.only(bottom: height * 0.02),
            color: Colors.grey,
          ),
        ),
        // Shimmer for List of Courses
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Number of shimmer placeholders
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: const Color.fromRGBO(22, 93, 255, 0.1),
                  ),
                  height: height * 0.15,
                  child: Row(
                    children: [
                      // Shimmer for course image
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.white,
                        child: Container(
                          width: width * 0.3,
                          height: height * 0.15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: width * .03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.01),
                          // Shimmer for course title
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white,
                            child: Container(
                              width: width * 0.5,
                              height: 12, // Adjust height as necessary
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: height * 0.006),
                          // Shimmer for course name
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white,
                            child: Container(
                              width: width * 0.5,
                              height: 16, // Adjust height as necessary
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          // Shimmer for buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Shimmer for Course Details button
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.white,
                                child: Container(
                                  width: width * 0.25,
                                  height: 30, // Adjust height as necessary
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: width * .02),
                              // Shimmer for Add to Class button
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.white,
                                child: Container(
                                  width: width * 0.25,
                                  height: 30, // Adjust height as necessary
                                  color: Colors.grey,
                                ),
                              ),
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
        ),
      ],
    ),
  );
}

}
