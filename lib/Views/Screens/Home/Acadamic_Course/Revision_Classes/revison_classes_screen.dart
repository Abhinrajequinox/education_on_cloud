import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/revision_classes_services.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/Revision_classes_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/drawer_of_academic_course.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/Revision_classes/revision_video_classs_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicRevisionVideoClass extends StatefulWidget {
  final String titleName;
  final String languageName;
  final String chapterId;
  final Color cardColor;
  final String titleOfChapter;
  final String courseId;
  const AcademicRevisionVideoClass(
      {super.key,
      required this.titleName,
      required this.languageName,
      required this.cardColor,
      required this.chapterId,
      required this.titleOfChapter,
      required this.courseId});

  @override
  State<AcademicRevisionVideoClass> createState() =>
      _AcademicRevisionVideoClassState();
}

final TheoryVideoClasssWidget theoryVideoClasssWidget =
    TheoryVideoClasssWidget();
final RevisionClassesServices revisionClassesServices =
    RevisionClassesServices();
// final TheoryVideoController theoryVideoController = TheoryVideoController();

class _AcademicRevisionVideoClassState
    extends State<AcademicRevisionVideoClass> {
  @override
  void initState() {
    academicDrawerController.incrementDrawerIndex();
    super.initState();
  }

  @override
  void dispose() {
    // Call the resetVideo method to clean up when the widget is disposed
    theoryVideoClasssWidget.theoryVideoController.resetVideo();
    theoryVideoClasssWidget.theoryVideoController.changeFavIcon(false);
    academicDrawerController.decrementDrawerIndex();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context, screenWidth, _scaffoldKey),
      body: _body(
          context: context,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          titleOfChapter: widget.titleName,
          chapterId: widget.chapterId,
          languageName: widget.languageName,
          cardColor: widget.cardColor),
      drawer: DrawerOfAcademicCourse(
          courseId: widget.courseId,
          titleOfChapter: widget.titleOfChapter,
          languageName: widget.languageName),
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
    required String chapterId,
    required String languageName,
    required Color cardColor}) {
  return FutureBuilder<List<AcademicTheoryChapterModelClass>>(
      future: revisionClassesServices.fetchAcademicTheoryClass(
        chaptId: chapterId,
        language: languageName,
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
                  theoryVideoClasssWidget.titleAndBackButton(
                      context, screenWidth, titleOfChapter),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  theoryVideoClasssWidget.listOfClass(
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
