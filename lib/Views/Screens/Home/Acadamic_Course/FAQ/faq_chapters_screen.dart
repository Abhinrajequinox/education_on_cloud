import 'dart:developer';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/faq_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/drawer_of_academic_course.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/FAQ/faq_chapter_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqChaptersScreen extends StatefulWidget {
  final String titleOfChapter;
  final String courseId;
  final String languageName;
  const FaqChaptersScreen(
      {super.key,
      required this.titleOfChapter,
      required this.courseId,
      required this.languageName});

  @override
  State<FaqChaptersScreen> createState() => _FaqChaptersScreenState();
}

final FaqChapterScreenWidget faqChapterScreenWidget=FaqChapterScreenWidget();
// final TheoryChapterScreenController theoryChapterScreenController =
//     TheoryChapterScreenController();
final AcademicFaqServices academicFaqServices=AcademicFaqServices();

class _FaqChaptersScreenState extends State<FaqChaptersScreen> {
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
      academicDrawerController.decrementDrawerIndex();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context, screenWidth, _scaffoldKey),
      body: _body(
        courseId: widget.courseId,
        languageName: widget.languageName,
        context: context,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        titleOfChapter: widget.titleOfChapter,
      ),
      drawer: DrawerOfAcademicCourse(
        languageName: widget.languageName,
        titleOfChapter: widget.titleOfChapter,
        // menuStructure: menuStructure,
        courseId: widget.courseId,
      ),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth,
    GlobalKey<ScaffoldState> _scaffoldKey) {
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
    required String courseId,
    required String languageName}) {
  return FutureBuilder<List<ChapterModel>>(
      future: academicFaqServices.fetchCourseChapters(
        courseId: courseId,
        language: languageName,
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
                  faqChapterScreenWidget.titleAndBackButton(
                      context, screenWidth, titleOfChapter),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  faqChapterScreenWidget.listOfChapters(
                      courseId: courseId,
                      titleOfChapter: titleOfChapter,
                      chapters: chapters!,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      languageName: languageName)
                ],
              ),
            ),
          );
        }
      });
}
