import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCategoryScreen extends StatefulWidget {
  final String titleOfCategory;
  final List<CourseCategoryModel> courseCategoryModel;
  const CourseCategoryScreen(
      {super.key,
      required this.titleOfCategory,
      required this.courseCategoryModel});

  @override
  State<CourseCategoryScreen> createState() => _CourseCategoryScreenState();
}

final LanguageController languageController = LanguageController();
final HomeScreenController homeScreenController = HomeScreenController();

class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(context, widget.titleOfCategory, screenWidth,
          widget.courseCategoryModel),
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
    List<CourseCategoryModel> courseCategoryModel) {
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
            SizedBox(
              width: 300,
              child: CustomText(
                text: titleOfCourse,
                maxline: 3,
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              CustomText(
                  text: 'Select your Course',
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: primarycolour,
                  )),
            ],
          ),
          listOfCourseSession(courseCategoryModel)
        ],
      ),
    ),
  );
}

Widget listOfCourseSession(List<CourseCategoryModel> courseCategoryModel) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      var course = courseCategoryModel[index];
      return GestureDetector(
        onTap: () {
          homeScreenController.changecategoryIndexForColor(index);
          Future.delayed(const Duration(milliseconds: 300), () {
            homeScreenController.changecategoryIndexForColor(100);
          });
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
                      text: course.categoryName,
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
    itemCount: courseCategoryModel.length,
  );
}
