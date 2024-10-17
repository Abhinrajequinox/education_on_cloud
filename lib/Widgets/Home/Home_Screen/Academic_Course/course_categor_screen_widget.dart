import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CourseCategorScreenWidget {
  final HomeScreenController homeScreenController = HomeScreenController();
  final AcademicCourseServices academicCourseServices =
      AcademicCourseServices();
  final LanguageController languageController = LanguageController();
  Widget listOfCourseSession(
      {required List<CourseCategoryModel> courseCategoryModel,
      required double screenHeight,
      required double screenWidth}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var course = courseCategoryModel[index];
        return GestureDetector(
          onTap: () {
            homeScreenController.changecategoryIndexForColor(index);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseScreen(
                    courseId: course.id,
                    titleOfCourse: course.categoryName,
                  ),
                ));
            Future.delayed(const Duration(milliseconds: 300), () {
              homeScreenController.changecategoryIndexForColor(100);
            });
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
                          // Handle image loading errors
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(
                              Icons
                                  .school_outlined, // Fallback icon (you can use any icon or widget here)
                              size: 40, // Adjust the size if needed
                              color: Colors.white, // Icon color
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: 270,
                        child: CustomText(
                          text: course.categoryName,
                          textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: homeScreenController
                                        .categoryIndexForColor.value ==
                                    index
                                ? Colors.white
                                : Colors.black,
                          ),
                          maxline: 1,
                        )),
                    const Icon(
                      Icons.arrow_forward_ios,
                    ),
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

}
