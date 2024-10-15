import 'dart:async';

import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/drawer_of_academic_course.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/theory_chapter_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TheoryChaptersScreen extends StatefulWidget {
  final String titleOfChapter;
  final String courseId;
  final List<ChapterModel> chapters;
  final String languageName;
  const TheoryChaptersScreen(
      {super.key,
      required this.titleOfChapter,
      required this.chapters,
      required this.courseId, required this.languageName});

  @override
  State<TheoryChaptersScreen> createState() => _TheoryChaptersScreenState();
}

final TheoryChaptersScreenWidget theoryChaptersScreenWidget =
    TheoryChaptersScreenWidget();

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _TheoryChaptersScreenState extends State<TheoryChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    List<AcademicMenuStructureModel> menuStructure = [];
    bool _drawerOpenedOnce = false; // Track if drawer opened already
    void _openDrawerAutomatically() {
      if (!_drawerOpenedOnce) {
        _scaffoldKey.currentState?.openDrawer();
        // _drawerOpenedOnce = true; // Ensure it happens only once
        Timer(const Duration(seconds: 3), () {
          _scaffoldKey.currentState?.closeDrawer();
        });
      }
    }

    void fetchMenu() async {
      menuStructure = await academicCourseServices.fetchMenuStructure(
          courseId: widget.courseId, mobileNum: '8592943588');
      setState(() {});
    }

    @override
    void initState() {
      super.initState();
      fetchMenu();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Open the drawer when the screen is loaded for the first time
        _openDrawerAutomatically();
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context, screenWidth),
      body: _body(languageName: widget.languageName,
          context: context,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          titleOfChapter: widget.titleOfChapter,
          chapters: widget.chapters),
      drawer: DrawerOfAcademicCourse(
          menuStructure: menuStructure,
          chapters: widget.chapters,
          courseId: widget.courseId,titleOfChapter: widget.titleOfChapter,),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
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
    required List<ChapterModel> chapters,required String languageName}) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(screenWidth * .05),
      child: Column(
        children: [
          theoryChaptersScreenWidget.titleAndBackButton(
              context, screenWidth, titleOfChapter),
          SizedBox(
            height: screenHeight * .01,
          ),
          theoryChaptersScreenWidget.listOfChapters(
              chapters: chapters,
              screenHeight: screenHeight,
              screenWidth: screenWidth,languageName:languageName)
        ],
      ),
    ),
  );
}

