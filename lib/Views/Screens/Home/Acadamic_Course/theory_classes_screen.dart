import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/theory_chapter_screen_widget.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/Academic_Course/theory_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicCourseTheoryClass extends StatefulWidget {
  final List<AcademicTheoryClassModel> theoryClass;
  final String titleName;
  final String languageName;
  final Color cardColor;
  const AcademicCourseTheoryClass(
      {super.key,
      required this.theoryClass,
      required this.titleName,
      required this.languageName,
      required this.cardColor});

  @override
  State<AcademicCourseTheoryClass> createState() =>
      _AcademicCourseTheoryClassState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final AcademicTheoryClassWidget academicTheoryClassWidget =
    AcademicTheoryClassWidget();

class _AcademicCourseTheoryClassState extends State<AcademicCourseTheoryClass> {
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
          titleOfChapter: widget.titleName,
          chapters: widget.theoryClass,
          languageName: widget.languageName,
          cardColor: widget.cardColor),
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
    required List<AcademicTheoryClassModel> chapters,
    required String languageName,
    required Color cardColor}) {
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
              languageName: languageName,cardColor:cardColor)
        ],
      ),
    ),
  );
}
