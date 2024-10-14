import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/chapter_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersScreen extends StatefulWidget {
  final String titleOfChapter;
  final List<ChapterModel> chapters;
  const ChaptersScreen(
      {super.key, required this.titleOfChapter, required this.chapters});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

final ChapterScreenWidget chapterScreenWidget = ChapterScreenWidget();

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(
          context: context,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          titleOfChapter: widget.titleOfChapter,
          chapters: widget.chapters),
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
            onPressed: () {},
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
    required List<ChapterModel> chapters}) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(screenWidth * .05),
      child: Column(
        children: [
          chapterScreenWidget.titleAndBackButton(
              context, screenWidth, titleOfChapter),
          chapterScreenWidget.listOfChapters(
              chapters: chapters, screenHeight: screenHeight,screenWidth: screenWidth)
        ],
      ),
    ),
  );
}
