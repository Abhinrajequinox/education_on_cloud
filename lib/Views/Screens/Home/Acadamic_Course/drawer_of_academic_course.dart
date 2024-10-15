import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/theory_chapters_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerOfAcademicCourse extends StatefulWidget {
  final List<ChapterModel> chapters;
  final String courseId;
  final String titleOfChapter;
  final List<AcademicMenuStructureModel> menuStructure;
  const DrawerOfAcademicCourse(
      {super.key,
      required this.menuStructure,
      required this.chapters,
      required this.courseId,
      required this.titleOfChapter});

  @override
  State<DrawerOfAcademicCourse> createState() => _DrawerOfAcademicCourseState();
}

final AcademicCourseServices academicCourseServices = AcademicCourseServices();

class _DrawerOfAcademicCourseState extends State<DrawerOfAcademicCourse> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Drawer(
          elevation: 0,
          child: Column(
            children: [
              Row(
                children: [Icon(Icons.close_sharp)],
              ),
              _customListTile(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => TheoryChaptersScreen(
                    //           titleOfChapter: widget.titleOfChapter,
                    //           chapters: widget.chapters,
                    //           courseId: widget.courseId),
                    //     ));
                    Navigator.pop(context);
                  },
                  title: 'Theory Classes'),
              _customListTile(onTap: () {}, title: 'Revision Classes'),
              _customListTile(onTap: () {}, title: 'Chapters'),
              _customListTile(onTap: () {}, title: 'FAQs'),
              _customListTile(onTap: () {}, title: 'Quick Tips'),
              _customListTile(onTap: () {}, title: 'Previous Year Papers'),
              _customListTile(onTap: () {}, title: 'Topic Test'),
              _customListTile(onTap: () {}, title: 'Chapter Test'),
              _customListTile(onTap: () {}, title: 'Mock Exam'),
              _customListTile(onTap: () {}, title: 'Saved Chats'),
              _customListTile(onTap: () {}, title: 'Favorite Videos'),
              CustomText(
                text: 'Personalized Panel',
                textStyle: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    decoration: TextDecoration.underline),
              ),
              _customListTile(onTap: () {}, title: 'Mock Exam Scores'),
            ],
          )),
    );
  }
}

Widget _customListTile({
  required void Function()? onTap,
  required String title,
}) {
  return ListTile(
    onTap: onTap,
    leading: Icon(Icons.class_sharp),
    title: CustomText(
      text: title,
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
    ),
    trailing: CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.play_circle,
        color: Colors.blue,
      ),
    ),
  );
}
