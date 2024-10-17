import 'dart:developer';

import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Auth/login_services.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Functions/auth_functions.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/chooselanguagescreen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/student_profile_screen.dart';
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
final AcademicCourseServices academicCourseServices = AcademicCourseServices();
final HomeScreenController homeScreenController = HomeScreenController();
final LoginServices loginServices = LoginServices();

class _HomeScreenState extends State<HomeScreen> {
  // @override
  void initState() {
    homeScreenController.fetchCourses();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context, screenWidth,screenHeight),
      body: _body(screenWidth, screenHeight, context),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth,double screenHeight) {
  // double screenWidth = MediaQuery.of(context).size.width;

  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentProfileScreen(),
                ));
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor:
                Colors.transparent, // Make sure no background color interferes
            child: ClipOval(
              child: Image.asset(
                'lib/Assets/Home/profile-image.png',
                fit: BoxFit.cover,
                width: screenWidth*0.1, // Diameter of CircleAvatar = 2 * radius
                height: screenHeight*0.05,
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,color: Colors.black,
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

Widget _body(double screenWidth, screenHeight, BuildContext context) {
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      homeScreenWidgets.coursePlans(screenWidth, screenHeight),
      homeScreenWidgets.searchCourse(screenWidth, screenHeight),
      homeScreenWidgets.categoryAndGrid(screenWidth, screenHeight),
      homeScreenWidgets.categoryBuilder(screenWidth, screenHeight),
      homeScreenWidgets.ourStatisticsText(screenWidth, screenHeight),
      homeScreenWidgets.ourStatisticsSession(screenWidth, screenHeight),
      homeScreenWidgets.coursesBoardsAndGrid(screenWidth, screenHeight),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 3,
              child: Column(children: [
                homeScreenWidgets.coursesAndBoardSession(
                    screenWidth, screenHeight),
                homeScreenWidgets.listOfgridOfcoursesAndBoardSession()
              ]))),
      homeScreenWidgets.ourProFeautureText(screenWidth, screenHeight),
      homeScreenWidgets.andTheFollowingFeaturesSession(
          screenWidth, screenHeight),
      homeScreenWidgets.differentModeOfLearningSession(
          screenWidth, screenHeight),
      homeScreenWidgets.differentModeOfLearningBuilder(
          screenHeight, screenWidth),
      homeScreenWidgets.yourLearningYourLanguageSession(
          screenHeight, screenWidth),
      homeScreenWidgets.countryBuilder(screenWidth, screenHeight),
      homeScreenWidgets.homeScreenlanguageList(
          context, screenHeight, screenWidth),
      homeScreenWidgets.continueWatching(screenHeight, screenWidth),
      homeScreenWidgets.ourExpertsSession(screenHeight, screenWidth),
      homeScreenWidgets.successFullLeanersSession(
          screenHeight: screenHeight, screenWidth: screenWidth),
      homeScreenWidgets.socialMediasBuilder(
          screenHeight: screenHeight, screenWidth: screenWidth),
      homeScreenWidgets.visitOutWebSiteText(),
      IconButton(
          onPressed: () {
            loginServices.logout();
            deleteUser();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ChooseLanguageScreen(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.exit_to_app))
    ]),
  );
}
