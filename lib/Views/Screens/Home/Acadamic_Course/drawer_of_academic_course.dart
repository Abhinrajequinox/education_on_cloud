import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Theory/theory_chapters_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerOfAcademicCourse extends StatefulWidget {
  final String courseId;
  final String titleOfChapter;
  final List<AcademicMenuStructureModel> menuStructure;
  const DrawerOfAcademicCourse(
      {super.key,
      required this.menuStructure,
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
                  title: 'Theory Classes',
                  icon:
                      'lib/Assets/Home/Drawer_icon/theory-class-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Revision Classes',
                  icon:
                      'lib/Assets/Home/Drawer_icon/revision-class-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Chapters',
                  icon: 'lib/Assets/Home/Drawer_icon/chapters-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'FAQs',
                  icon: 'lib/Assets/Home/Drawer_icon/FAQ-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Quick Tips',
                  icon: 'lib/Assets/Home/Drawer_icon/quick-tip-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Previous Year Papers',
                  icon:
                      'lib/Assets/Home/Drawer_icon/previous-q-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Topic Test',
                  icon: 'lib/Assets/Home/Drawer_icon/topic-test-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Chapter Test',
                  icon:
                      'lib/Assets/Home/Drawer_icon/chapter-test-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Mock Exam',
                  icon: 'lib/Assets/Home/Drawer_icon/mock-exam-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Saved Chats',
                  icon: 'lib/Assets/Home/Drawer_icon/saved-chat-img-icon.png'),
              _customListTile(
                  onTap: () {},
                  title: 'Favorite Videos',
                  icon: 'lib/Assets/Home/Drawer_icon/fav-video-img-icon.png'),
              CustomText(
                text: 'Personalized Panel',
                textStyle: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    decoration: TextDecoration.underline),
              ),
              _customListTile(
                  onTap: () {},
                  title: 'Mock Exam Scores',
                  icon: 'lib/Assets/Home/Drawer_icon/mock-exam-img-icon.png'),
            ],
          )),
    );
  }
}

Widget _customListTile({
  required void Function()? onTap,
  required String title,
  required String icon,
}) {
  return ListTile(
    onTap: onTap,
    leading: Image.asset(
      icon,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
    ),
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
