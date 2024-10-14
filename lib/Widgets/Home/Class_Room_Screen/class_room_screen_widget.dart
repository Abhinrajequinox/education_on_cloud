import 'dart:convert';
import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/Home/home_screen_utilities.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_session_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_bottom_navigation_bar.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassRoomScreenWidget {
  final HomeScreenController homeScreenController = HomeScreenController();
  final AcademicCourseServices academicCourseServices = AcademicCourseServices();

  Widget titleAndBackButton(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * .05),
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const HomeBottomNavigationBar(),
                    ));
              },
              child: const ImageIcon(
                  AssetImage('lib/Assets/Icons/arrow-circle-left.png'),
                  size: 30),
            ),
            SizedBox(width: screenWidth * .03),
            CustomText(
              text: "Category",
              textStyle:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              CustomText(
                  text: 'Select The Course',
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: primarycolour,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Future<List<dynamic>> _fetchCategory() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(categoryJson);
      return jsonData['category'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Widget categoryBuilder(
    double screenWidth,
    double screenHeight,
  ) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No category available.'));
        }
        final category = snapshot.data!;
        return listviewOfCategory(
          category,
          screenWidth,
          screenHeight,
        );
      },
    );
  }

////////////////   List view of the Fetched Categorires

  Widget listviewOfCategory(
    List<dynamic> category,
    double screenWidth,
    double screenHeight,
  ) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              bottom: screenWidth * 0.03), // 4% horizontal padding
          child: GestureDetector(
            onTap: () async {
              homeScreenController.changecategoryIndexForColor(index);
              List<CourseSectionModel> _course_section =
                  await academicCourseServices.fetchCoursesSection('0');
              // log(_course_section.toString());
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  //  homeScreenController.changecategoryIndexForColor(100);
                  return CourseSessionScreen(
                    courseSectionModel: _course_section,
                    titleOfCourse: cata['categorytitle'],
                  );
                },
              ));
              Future.delayed(const Duration(milliseconds: 300), () {
                homeScreenController.changecategoryIndexForColor(100);
              });
            },
            child: Obx(
              () => Card(
                elevation: 2,
                child: Container(
                  height: screenHeight * 0.09, // 9% of screen height
                  decoration: BoxDecoration(
                      gradient:
                          homeScreenController.categoryIndexForColor == index
                              ? const LinearGradient(colors: [
                                  Color.fromRGBO(0, 56, 255, 1),
                                  Color.fromRGBO(0, 224, 255, 1)
                                ])
                              : const LinearGradient(
                                  colors: [Colors.white, Colors.white]),
                      border: Border.all(width: .002),
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.07, // 7% of screen height
                        width: screenHeight * 0.07, // 7% of screen height
                        child: Image.asset(
                          cata['categoryimage'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: cata['categorytitle'],
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenHeight * 0.018,
                                  color: homeScreenController
                                              .categoryIndexForColor ==
                                          index
                                      ? Colors.white
                                      : Colors.black), // 1.5% of screen height
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 13),
                              CustomText(
                                text: cata['categoryrating'],
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * 0.012,
                                    color: homeScreenController
                                                .categoryIndexForColor ==
                                            index
                                        ? Colors.white
                                        : const Color.fromRGBO(130, 130, 130,
                                            1)), // 1.5% of screen height
                              ),
                              CustomText(
                                text: cata['categorystd'],
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * 0.012,
                                    color: homeScreenController
                                                .categoryIndexForColor ==
                                            index
                                        ? Colors.white
                                        : const Color.fromRGBO(130, 130, 130,
                                            1)), // 1.5% of screen height
                              ),
                              CustomText(
                                text: cata['categorycourse'],
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * 0.012,
                                    color: homeScreenController
                                                .categoryIndexForColor ==
                                            index
                                        ? Colors.white
                                        : const Color.fromRGBO(130, 130, 130,
                                            1)), // 1.5% of screen height
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.1,
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: category.length,
    );
  }
}
