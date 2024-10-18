import 'dart:developer';

import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Chapters/chapter_chaptes_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Revision_Classes/revision_chapter_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Theory/theory_chapters_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerOfAcademicCourse extends StatefulWidget {
  final String courseId;
  final String titleOfChapter;
  final String languageName;
  // final List<AcademicMenuStructureModel> menuStructure;

  const DrawerOfAcademicCourse({
    super.key,
    // required this.menuStructure,
    required this.courseId,
    required this.titleOfChapter,
    required this.languageName,
  });

  @override
  State<DrawerOfAcademicCourse> createState() => _DrawerOfAcademicCourseState();
}

class AcademicDrawerController extends GetxController {
  RxInt drawerIntex = 0.obs;

  void incrementDrawerIndex() {
    drawerIntex.value++;
  }

  void decrementDrawerIndex() {
    if (drawerIntex.value > 0) {
      drawerIntex.value--;
    }
  }
}

final AcademicDrawerController academicDrawerController =
    AcademicDrawerController();
final AcademicCourseServices academicCourseServices = AcademicCourseServices();

class _DrawerOfAcademicCourseState extends State<DrawerOfAcademicCourse> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Drawer(
        key: _drawerKey,
        elevation: 0,
        child: Column(
          children: [
            // Close Button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close_sharp),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            // Custom List Tiles with Local Images
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();

                for (int i = 0;
                    i <= academicDrawerController.drawerIntex.value;
                    i++) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
                academicDrawerController.drawerIntex.value = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TheoryChaptersScreen(
                        titleOfChapter: widget.titleOfChapter,
                        courseId: widget.courseId,
                        languageName: widget
                            .languageName), // Replace with your new screen
                  ),
                );
              },
              title: 'Theory Classes',
              icon: 'lib/Assets/Home/Drawer_icon/theory-class-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
                log('when on tap on the list tile ${academicDrawerController.drawerIntex.value.toString()}');
                for (int i = 0;
                    i <= academicDrawerController.drawerIntex.value;
                    i++) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
                academicDrawerController.drawerIntex.value = 0;
                log('after on tap on the list tile ${academicDrawerController.drawerIntex.value.toString()}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RevisionChapterScreen(
                        titleOfChapter: widget.titleOfChapter,
                        courseId: widget.courseId,
                        languageName: widget
                            .languageName), // Replace with your new screen
                  ),
                );
              },
              title: 'Revision Classes',
              icon: 'lib/Assets/Home/Drawer_icon/revision-class-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
                log('when on tap on the list tile ${academicDrawerController.drawerIntex.value.toString()}');
                for (int i = 0;
                    i <= academicDrawerController.drawerIntex.value;
                    i++) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
                academicDrawerController.drawerIntex.value = 0;
                log('after on tap on the list tile ${academicDrawerController.drawerIntex.value.toString()}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterScreenChapter(
                        titleOfChapter: widget.titleOfChapter,
                        courseId: widget.courseId,
                        languageName: widget
                            .languageName), // Replace with your new screen
                  ),
                );
              },
              title: 'Chapters',
              icon: 'lib/Assets/Home/Drawer_icon/chapters-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'FAQs',
              icon: 'lib/Assets/Home/Drawer_icon/FAQ-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Quick Tips',
              icon: 'lib/Assets/Home/Drawer_icon/quick-tip-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Previous Year Papers',
              icon: 'lib/Assets/Home/Drawer_icon/previous-q-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Topic Test',
              icon: 'lib/Assets/Home/Drawer_icon/topic-test-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Chapter Test',
              icon: 'lib/Assets/Home/Drawer_icon/chapter-test-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Mock Exam',
              icon: 'lib/Assets/Home/Drawer_icon/mock-exam-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Saved Chats',
              icon: 'lib/Assets/Home/Drawer_icon/saved-chat-img-icon.png',
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Favorite Videos',
              icon: 'lib/Assets/Home/Drawer_icon/fav-video-img-icon.png',
            ),
            CustomText(
              text: 'Personalized Panel',
              textStyle: GoogleFonts.mulish(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
            _customListTile(
              onTap: () {
                _drawerKey.currentState?.closeDrawer();
              },
              title: 'Mock Exam Scores',
              icon: 'lib/Assets/Home/Drawer_icon/mock-exam-img-icon.png',
            ),
          ],
        ),
      ),
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
      'lib/Assets/Home/Drawer_icon/topic-test-img-icon.png',
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
            Icons.error); // Fallback in case the image fails to load
      },
    ),
    title: CustomText(
      text: title,
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),
    trailing: const CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.play_circle,
        color: Colors.blue,
      ),
    ),
  );
}
