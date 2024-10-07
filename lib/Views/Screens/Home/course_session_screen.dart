import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Utilities/Home/course_classes_utilities.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/course_category_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSessionScreen extends StatefulWidget {
  final List<CourseSectionModel> courseSectionModel;
  final String titleOfCourse;
  const CourseSessionScreen(
      {super.key,
      required this.courseSectionModel,
      required this.titleOfCourse});

  @override
  State<CourseSessionScreen> createState() => _CategoryClassesScreenState();
}

final LanguageController languageController = LanguageController();
final CourseClassesUtilities courseClassesUtilities = CourseClassesUtilities();
final HomeScreenController homeScreenController = HomeScreenController();

class _CategoryClassesScreenState extends State<CourseSessionScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCourse, screenWidth,
          widget.courseSectionModel),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        const CircleAvatar(radius: 18),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
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

Widget _body(BuildContext context, String titleOfCourse, double screenWidth,
    List<CourseSectionModel> courseSection) {
  return Padding(
    padding: EdgeInsets.all(screenWidth * .05),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ImageIcon(
                  AssetImage('lib/Assets/Icons/arrow-circle-left.png'),
                  size: 30),
            ),
            SizedBox(width: screenWidth * .03),
            CustomText(
              text: titleOfCourse,
              textStyle:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              CustomText(
                  text: 'Select Your Board',
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: primarycolour,
                  )),
            ],
          ),
          listOfCourseSession(courseSection)
        ],
      ),
    ),
  );
}

Widget listOfCourseSession(List<CourseSectionModel> courseSection) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      var course = courseSection[index];
      return GestureDetector(
        onTap: () async {
          List<CourseCategoryModel> courseCategoryModel =
              await homeScreenServices.fetchCoursesCategory(course.sectionId);
          homeScreenController.changecategoryIndexForColor(index);
          Future.delayed(const Duration(milliseconds: 300), () {
            homeScreenController.changecategoryIndexForColor(100);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseCategoryScreen(
                    titleOfCategory: course.sectionName,
                    courseCategoryModel: courseCategoryModel),
              ));
        },
        child: Obx(
          () => Card(
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                  color:
                      homeScreenController.categoryIndexForColor.value == index
                          ? Colors.blue
                          : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.all(8),
              height: 60,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: ClipOval(
                      child: Image.network(
                        course.img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 270,
                    child: CustomText(
                      text: course.sectionName,
                      textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400, fontSize: 14),
                      maxline: 1,
                      color: homeScreenController.categoryIndexForColor.value ==
                              index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      );
    },
    itemCount: courseSection.length,
  );
}
