import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/home_screen_services.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/course_category_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSessionWidget {
  final HomeScreenController homeScreenController = HomeScreenController();
  final HomeScreenServices homeScreenServices = HomeScreenServices();

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
                    color: homeScreenController.categoryIndexForColor.value ==
                            index
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
                        color:
                            homeScreenController.categoryIndexForColor.value ==
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

  Widget titleAndBackButton(
      BuildContext context, double screenWidth, String titleOfCourse) {
    return Column(
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
        )
      ],
    );
  }
}
