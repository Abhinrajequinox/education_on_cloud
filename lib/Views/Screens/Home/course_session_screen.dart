import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Utilities/Home/course_classes_utilities.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/course_session_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSessionScreen extends StatefulWidget {
  final List<CourseSectionModel> courseSectionModel;
  final String titleOfCourse;
  const CourseSessionScreen(
      {super.key,
      required this.courseSectionModel,
      required this.titleOfCourse});

  @override
  State<CourseSessionScreen> createState() => _CategoryClassesScreenState();
}

final LanguageController languageController = LanguageController();
final CourseSessionWidget courseSessionWidget=CourseSessionWidget();

class _CategoryClassesScreenState extends State<CourseSessionScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCourse, screenWidth,
          widget.courseSectionModel),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        const CircleAvatar(radius: 18),
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
    List<CourseSectionModel> courseSection) {
  return Padding(
    padding: EdgeInsets.all(screenWidth * .05),
    child: SingleChildScrollView(
      child: Column(
        children: [
         courseSessionWidget.titleAndBackButton(context, screenWidth, titleOfCourse),
          courseSessionWidget.listOfCourseSession(courseSection)
        ],
      ),
    ),
  );
}


