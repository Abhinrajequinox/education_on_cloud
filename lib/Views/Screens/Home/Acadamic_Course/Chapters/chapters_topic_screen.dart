import 'dart:async';
import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/theory_chapter_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/chapters_services.dart';
import 'package:education_on_cloud/Functions/auth_functions.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/chapters_model.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/drawer_of_academic_course.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/Chapters/chapters_topics_widget.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/Theory/theory_chapter_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersTopicScreen extends StatefulWidget {
  final String titleName;
  final String languageName;
  final String chapterId;
  final Color cardColor;
  final String titleOfChapter;
  final String courseId;
  const ChaptersTopicScreen(
      {super.key,
      required this.titleOfChapter,
      required this.courseId,
      required this.languageName,
      required this.titleName,
      required this.chapterId,
      required this.cardColor});

  @override
  State<ChaptersTopicScreen> createState() => _ChaptersTopicScreenState();
}

final ChaptersTopicsWidget chaptersTopicsWidget = ChaptersTopicsWidget();
final TheoryChapterScreenController theoryChapterScreenController =
    TheoryChapterScreenController();
final AcademicChaptersServices academicChaptersServices =
    AcademicChaptersServices();

class _ChaptersTopicScreenState extends State<ChaptersTopicScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
      super.initState();
      academicDrawerController.incrementDrawerIndex();
    }

    @override
    void dispose() {
      super.dispose();
      theoryChapterScreenController.isExpanded(-1);
      academicDrawerController.decrementDrawerIndex();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context, screenWidth, _scaffoldKey),
      body: _body(
          cardColor: widget.cardColor,
          chapterId: widget.chapterId,
          courseId: widget.courseId,
          languageName: widget.languageName,
          context: context,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          titleOfChapter: widget.titleOfChapter,
          titleName: widget.titleName),
      drawer: DrawerOfAcademicCourse(
          titleOfChapter: widget.titleOfChapter,
          // menuStructure: menuStructure,
          courseId: widget.courseId,
          languageName: widget.languageName),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth,
    GlobalKey<ScaffoldState> _scaffoldKey) {
  academicDrawerController.incrementDrawerIndex();
  log('while reached on the chapter screen ${academicDrawerController.drawerIntex.value.toString()}');

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
    required String titleName,
    required String courseId,
    required String chapterId,
    required Color cardColor,
    required String languageName}) {
  log(courseId);
  return FutureBuilder<List<ChapterSubTopicModel>>(
      future: academicChaptersServices.fetchCourseChapters(
        chapId: chapterId,
      ),
      builder: (context, snapshot) {
        // Handle different states of the Future
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: customShimmerForList(screenHeight, screenWidth),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there's no data or the data is empty, show a message
          return const Center(
            child: Text('No chapters found'),
          );
        } else {
          var chapters = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * .05),
              child: Column(
                children: [
                  chaptersTopicsWidget.titleAndBackButton(
                      context, screenWidth, titleOfChapter, titleName),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    height: screenHeight * .04,
                    width: screenWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.g_translate),
                        CustomText(
                          text: 'Select your language here',
                          color: Colors.black,
                          textStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        SizedBox(
                          width: screenWidth * .1,
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                  chaptersTopicsWidget.languageChangeDropDown(screenHeight),
                  chaptersTopicsWidget.listOfChapters(
                    cardColor: cardColor,
                    chapters: chapters!,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    languageName: languageName,
                    titleOfChapter: titleOfChapter,
                  )
                ],
              ),
            ),
          );
        }
      });
}
