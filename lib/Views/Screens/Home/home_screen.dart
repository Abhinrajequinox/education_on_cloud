import 'dart:developer';

import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/home_screen_services.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
final HomeScreenServices homeScreenServices = HomeScreenServices();
final HomeScreenController homeScreenController = HomeScreenController();

class _HomeScreenState extends State<HomeScreen> {
//  late Future<List<CourseCategory>?> futureCategories;

  @override
  void initState()  {
    super.initState();
   _fetchCourses();
  }
  void _fetchCourses() async {
   homeScreenController.courseSessionList.clear(); // Clear previous data
    try {
      var fetchedCourses = await homeScreenServices.fetchCoursesSection('0'); // Fetch courses
      homeScreenController.changeCourseSessionList(fetchedCourses); // Update the controller with new data
    } catch (error) {
      log('Error fetching courses: $error'); // Log error if fetching fails
    } }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(screenWidth, screenHeight),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  // double screenWidth = MediaQuery.of(context).size.width;

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

Widget _body(
  double screenWidth,
  screenHeight,
) {
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      homeScreenWidgets.coursePlans(screenWidth, screenHeight),
      homeScreenWidgets.searchCourse(screenWidth, screenHeight),
      homeScreenWidgets.categoryAndGrid(screenWidth, screenHeight),
      homeScreenWidgets.categoryBuilder(screenWidth, screenHeight),
      homeScreenWidgets.ourStatisticsText(screenWidth, screenHeight),
      homeScreenWidgets.ourStatisticsSession(screenWidth, screenHeight),
      homeScreenWidgets.coursesBoardsAndGrid(screenWidth, screenHeight),
      homeScreenWidgets.coursesAndBoardSession(screenWidth, screenHeight),
      homeScreenWidgets.listOfgridOfcoursesAndBoardSession(),
      homeScreenWidgets.ourProFeautureText(screenWidth, screenHeight),
    ]),
  );
}
