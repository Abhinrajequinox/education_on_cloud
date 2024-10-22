import 'dart:developer';

import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/theory_video_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/drawer_of_academic_course.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/Theory/theory_chapter_screen_widget.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/Theory/theory_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicCourseTheoryClass extends StatefulWidget {
  final String titleName;
  final String languageName;
  final String drawerCourseId;
  final String drawertitleOfChapter;
  final String chapterId;
  final Color cardColor;
  const AcademicCourseTheoryClass(
      {super.key,
      required this.titleName,
      required this.languageName,
      required this.cardColor,
      required this.chapterId,
      required this.drawerCourseId,
      required this.drawertitleOfChapter});

  @override
  State<AcademicCourseTheoryClass> createState() =>
      _AcademicCourseTheoryClassState();
}

final AcademicTheoryClassWidget academicTheoryClassWidget =
    AcademicTheoryClassWidget();
final AcademicCourseServices academicCourseServices = AcademicCourseServices();
// final TheoryVideoController theoryVideoController = TheoryVideoController();

class _AcademicCourseTheoryClassState extends State<AcademicCourseTheoryClass> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    academicDrawerController.incrementDrawerIndex();
  }

  @override
  void dispose() {
    // Call the resetVideo method to clean up when the widget is disposed
    academicTheoryClassWidget.theoryVideoController.resetVideo();
    academicTheoryClassWidget.theoryVideoController.changeFavIcon(false);
    academicDrawerController.decrementDrawerIndex();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('while reached on the video screen ${academicDrawerController.drawerIntex.value.toString()}');

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(context, screenWidth, scaffoldKey),
      body: _body(
          context: context,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          titleOfChapter: widget.titleName,
          chapterId: widget.chapterId,
          languageName: widget.languageName,
          cardColor: widget.cardColor),
      drawer: DrawerOfAcademicCourse(
          courseId: widget.drawerCourseId,
          titleOfChapter: widget.drawertitleOfChapter,
          languageName: widget.languageName),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth,
    GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.list_outlined,
                color: Colors.black, size: screenWidth * 0.09)),
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
    required double screenWidth,
    required double screenHeight,
    required String titleOfChapter,
    required String chapterId,
    required String languageName,
    required Color cardColor}) {
      log(languageName);
      log(chapterId);
  return FutureBuilder<List<AcademicTheoryClassModel>>(
      future: academicCourseServices.fetchAcademicTheoryClass(
        chaptId: chapterId,
        language: 'English',
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: customShimmerForList(screenHeight, screenWidth),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there's no data or the data is empty, show a message
          return const Center(child: Text('No theory classes found'));
        } else {
          var chapters = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * .05),
              child: Column(
                children: [
                  academicTheoryClassWidget.titleAndBackButton(
                      context, screenWidth, titleOfChapter),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  academicTheoryClassWidget.listOfClass(
                      titleOfClass: titleOfChapter,
                      classes: chapters,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      languageName: languageName,
                      cardColor: cardColor)
                ],
              ),
            ),
          );
        }
      });
}
