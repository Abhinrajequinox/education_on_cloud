import 'dart:developer';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/course_categor_screen_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCategoryScreen extends StatefulWidget {
  final String titleOfCategory;
  final String sectionId;
  // final List<CourseCategoryModel> courseCategoryModel;
  const CourseCategoryScreen({
    super.key,
    required this.titleOfCategory,
    required this.sectionId,
  });

  @override
  State<CourseCategoryScreen> createState() => _CourseCategoryScreenState();
}

final LanguageController languageController = LanguageController();
final HomeScreenController homeScreenController = HomeScreenController();
final CourseCategorScreenWidget courseCategorScreenWidget=CourseCategorScreenWidget();
final AcademicCourseServices academicCourseServices=AcademicCourseServices();
class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCategory, screenWidth, screenHeight,
          widget.sectionId),
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
    double screenHeight, String sessionId) {
  return FutureBuilder<List<CourseCategoryModel>>(
      future: academicCourseServices.fetchCoursesCategory(sessionId),
      builder: (context, snapshot) {
        // Handle different states of the Future
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while fetching data
          return Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: customShimmerForList(screenHeight, screenWidth),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle empty data case
          return const Center(
            child: Text('No courses available'),
          );
        } else {
          var courseCategoryModel = snapshot.data;
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
                courseCategorScreenWidget.  listOfCourseSession(
                      courseCategoryModel: courseCategoryModel!,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth)
                ],
              ),
            ),
          );
        }
      });
}


