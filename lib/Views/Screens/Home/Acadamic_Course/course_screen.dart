import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/course_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/course_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseScreen extends StatefulWidget {
  final List<CourseModel> course;
  final String titleOfCourse;
  const CourseScreen(
      {super.key, required this.course, required this.titleOfCourse});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

final CourseScreenWidget courseScreenWidget = CourseScreenWidget();
  final CourseScreenController courseScreenController=CourseScreenController();


class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(
          context: context,
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          titleOfCourse: widget.titleOfCourse,
          courses: widget.course),
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
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
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

Widget _body(
    {required BuildContext context,
    required double screenHeight,
    required double screenWidth,
    required String titleOfCourse,
    required List<CourseModel> courses}) {
  return Padding(
    padding: EdgeInsets.all(screenWidth * .05),
    child: SingleChildScrollView(
      child: Column(
        children: [
          courseScreenWidget.titleAndBackButton(
              context, screenWidth, titleOfCourse),
          courseScreenWidget.listOfCourses(
              courses: courses,
              screenHeight: screenHeight,
              screenWidth: screenWidth,titleOfCourse: titleOfCourse)
        ],
      ),
    ),
  );
}
