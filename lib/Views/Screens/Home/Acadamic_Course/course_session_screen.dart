import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Functions/auth_functions.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/course_session_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSessionScreen extends StatefulWidget {
  final String titleOfCourse;
  final String country;
  const CourseSessionScreen({super.key, required this.titleOfCourse, required this.country});

  @override
  State<CourseSessionScreen> createState() => _CategoryClassesScreenState();
}

final LanguageController languageController = LanguageController();
final CourseSessionWidget courseSessionWidget = CourseSessionWidget();
final AcademicCourseServices academicCourseServices = AcademicCourseServices();
class _CategoryClassesScreenState extends State<CourseSessionScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor:
      //     languageController.currentTheme.value.scaffoldBackgroundColor,
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCourse, screenWidth, screenHeight),
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

Widget _body(BuildContext context, String titleOfCourse, double screenWidth,
    double screenHeight) {
  return FutureBuilder<List<CourseSectionModel>>(
      future: academicCourseServices.fetchCoursesSection('0'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return Padding(
            padding:EdgeInsets.all(screenWidth * .05),
            child: customShimmerForList(screenHeight, screenWidth),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there's no data or the data is empty, show a message
          return const Center(child: Text('No course sections found'));
        } else {
          var courseSecion = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  courseSessionWidget.titleAndBackButton(
                      context, screenWidth, titleOfCourse),
                  courseSessionWidget.listOfCourseSession(courseSecion)
                ],
              ),
            ),
          );
        }
      });
}
