import 'dart:developer';

import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_category_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSessionWidget {
  final HomeScreenController homeScreenController = HomeScreenController();
  final AcademicCourseServices academicCourseServices =
      AcademicCourseServices();

  Widget listOfCourseSession(List<CourseSectionModel> courseSection) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var course = courseSection[index];
        return GestureDetector(
          onTap: () {
            homeScreenController.changecategoryIndexForColor(index);
            Future.delayed(const Duration(milliseconds: 300), () {
              homeScreenController.changecategoryIndexForColor(100);
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseCategoryScreen(
                      titleOfCategory: course.sectionName,
                      sectionId: course.sectionId,),
                ));
          },
          child: Obx(
            () => Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: homeScreenController.categoryIndexForColor.value ==
                            index
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                padding: const EdgeInsets.all(8),
                height: 60,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                        child: Image.network(
                          course.img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (BuildContext context, Object exception,
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
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 270,
                      child: FutureBuilder<String>(
                        future: languageController
                            .translateApiText(course.sectionName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                                'Loading...'); // Placeholder while translating
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error: ${snapshot.error}'); // Error handling
                          } else {
                            // Successfully translated
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomText(
                                    text: snapshot.data ??
                                        course
                                            .sectionName, // Use original text if translation fails
                                    textStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: homeScreenController
                                                  .categoryIndexForColor
                                                  .value ==
                                              index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    maxline: 1,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: courseSection.length,
    );
  }

  Widget titleAndBackButton(
      BuildContext context, double screenWidth, String titleOfCourse) {
    return Column(
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
          CustomText(
            text: titleOfCourse,
            textStyle:
                GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
          )
        ]),
        Row(
          children: [
            SizedBox(width: screenWidth * .102),
            CustomText(
                text: 'Select Your Board',
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: primarycolour,
                )),
          ],
        )
      ],
    );
  }
}
