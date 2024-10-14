import 'dart:developer';

import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCategoryScreen extends StatefulWidget {
  final String titleOfCategory;
  final List<CourseCategoryModel> courseCategoryModel;
  const CourseCategoryScreen(
      {super.key,
      required this.titleOfCategory,
      required this.courseCategoryModel});

  @override
  State<CourseCategoryScreen> createState() => _CourseCategoryScreenState();
}

final LanguageController languageController = LanguageController();
final HomeScreenController homeScreenController = HomeScreenController();

class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCategory, screenWidth,
          widget.courseCategoryModel),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        CircleAvatar(
          radius: 18,
          backgroundColor:
              Colors.transparent, // Make sure no background color interferes
          child: ClipOval(
            child: Image.asset(
              'lib/Assets/Home/profile-image.png',
              fit: BoxFit.cover,
              width: 36, // Diameter of CircleAvatar = 2 * radius
              height: 36,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
            iconSize: screenWidth * 0.09),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: screenWidth * 0.08,
            width: screenWidth * 0.30,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: CustomText(
                  text: 'Subscribe Now',
                  textStyle: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        )
      ]),
      leadingWidth: screenWidth * 0.7,
      actions: [
        Image.asset('lib/Assets/titlelogo.png', width: screenWidth * 0.25),
        SizedBox(width: screenWidth * 0.05)
      ]);
}

Widget _body(BuildContext context, String titleOfCourse, double screenWidth,
    List<CourseCategoryModel> courseCategoryModel) {
  return Padding(
    padding: EdgeInsets.all(screenWidth * .05),
    child: SingleChildScrollView(
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
              width: 300,
              child: CustomText(
                text: titleOfCourse,
                maxline: 3,
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              CustomText(
                  text: 'Select your Course',
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: primarycolour,
                  )),
            ],
          ),
          listOfCourseSession(courseCategoryModel)
        ],
      ),
    ),
  );
}

Widget listOfCourseSession(List<CourseCategoryModel> courseCategoryModel) {
  log(homeScreenController.isLoadingcoursecategoryModel.value.toString());
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      var course = courseCategoryModel[index];
      return GestureDetector(
        onTap: () async {
          homeScreenController.changecategoryIndexForColor(index);
          log(' the catid send is ${course.id}');
          var _courses = await academicCourseServices.fetchCourses(course.id);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseScreen(
                  course: _courses,
                  titleOfCourse: course.categoryName,
                ),
              ));
          Future.delayed(const Duration(milliseconds: 300), () {
            homeScreenController.changecategoryIndexForColor(100);
          });
        },
        child: Obx(
          () => Card(
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                  color:
                      homeScreenController.categoryIndexForColor.value == index
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
                        // Handle image loading errors
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
                          .translateApiText(course.categoryName),
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
                          return CustomText(
                            text: snapshot.data ?? course.categoryName,
                            textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: homeScreenController
                                          .categoryIndexForColor.value ==
                                      index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            maxline: 1,
                          );
                        }
                      },
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    itemCount: courseCategoryModel.length,
  );
}
