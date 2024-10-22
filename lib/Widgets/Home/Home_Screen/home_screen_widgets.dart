import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:education_on_cloud/Controller/AuthController/languagecontroller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Controller/Services/Home/home_screen_services.dart';
import 'package:education_on_cloud/Functions/auth_functions.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/Home/home_screen_utilities.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_category_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_session_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenWidgets {
  final HomeScreenController homeScreenController = HomeScreenController();
  final AcademicCourseServices academicCourseServices =
      AcademicCourseServices();
  final HomeScreenServices homeScreenServices = HomeScreenServices();
  final LanguageController languageController = LanguageController();

  // Course Plans

  Widget coursePlans(double screenWidth, double screenHeight) {
    return FutureBuilder<List<dynamic>>(
        future: _fetchPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                height: screenHeight * 0.25, // 25% of screen height
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (context, index, realIndex) {
                return customShimmer(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.2,
                );
              },
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No plans available.'));
          } else {
            final plans = snapshot.data!;

            return CarouselSlider.builder(
              itemCount: plans.length,
              options: CarouselOptions(
                height: screenHeight * 0.25, // 25% of screen height
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (context, index, realIndex) {
                final plan = plans[index];
                return index % 2 == 0
                    ? cardForPlan(plan, const Color.fromRGBO(27, 40, 63, 1),
                        screenWidth, screenHeight)
                    : cardForPlan(plan, const Color.fromRGBO(63, 50, 27, 1),
                        screenWidth, screenHeight);
              },
            );
          }
        });
  }

  /// card for the plan of the card

  Widget cardForPlan(
      dynamic plan, Color color, double screenWidth, double screenHeight) {
    return Card(
      color: color,
      margin:
          EdgeInsets.all(screenWidth * 0.04), // 4% of screen width as margin
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: screenWidth * 0.95, // 95% of screen width
          padding: const EdgeInsets.all(0),
          child: Image.asset(plan['planimage']),
        ),
      ),
    );
  }

  /// Fetch the category plans

  Future<List<dynamic>> _fetchPlans() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(plansJson);
      return jsonData['plans'];
    } catch (e) {
      throw Exception('Failed to load plans: $e');
    }
  }

///// The category name and the Grid And ListView Button

  Widget categoryAndGrid(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04), // 4% horizontal padding
      child: Obx(() =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Stack(children: [
              CustomText(
                  text: 'Category',
                  textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight *
                          0.02)), // Font size as 2% of screen height
              Positioned(
                  left: screenWidth * 0.05, // Positioning based on screen width
                  top: screenHeight * 0.03,
                  child: SizedBox(
                      width: screenWidth * 0.16, // 16% of screen width
                      child: Image.asset('lib/Assets/Onboard/image.png')))
            ]),
            homeScreenController.categoryListOrGrid.value
                ? IconButton(
                    onPressed: () {
                      homeScreenController.changecategoryListOrGrid(false);
                    },
                    icon: const Icon(Icons.grid_view_outlined))
                : IconButton(
                    onPressed: () {
                      homeScreenController.changecategoryListOrGrid(true);
                    },
                    icon: const Icon(Icons.list))
          ])),
    );
  }

//// Search Feild For the Cousrse

  Widget searchCourse(double screenWidth, double screenHeight) {
    return Padding(
      padding:
          EdgeInsets.all(screenWidth * 0.04), // Padding as 4% of screen width
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintStyle: GoogleFonts.mulish(),
          hintText: 'Search for course',
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
        ),
      ),
    );
  }

  ///Fetch the categorys

  Future<List<dynamic>> _fetchCategory() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(categoryJson);
      return jsonData['category'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  /// Builder for the Fetching the categories

  Widget categoryBuilder(
    double screenWidth,
    double screenHeight,
  ) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return shimerListviewOfCatefgory(
              screenHeight: screenHeight, screenWidth: screenWidth);
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No category available.'));
        } else {
          final category = snapshot.data!;
          return Obx(() => homeScreenController.categoryListOrGrid.value
              ? listviewOfCategory(
                  category,
                  screenWidth,
                  screenHeight,
                )
              : gridViewOfCategory(
                  category,
                  screenWidth,
                  screenHeight,
                ));
        }
      },
    );
  }

//// Grid view Of the Fetched Categories

  Widget gridViewOfCategory(
    List<dynamic> category,
    double screenWidth,
    double screenHeight,
  ) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04), // 4% horizontal padding
          child: GestureDetector(
            onTap: () async {
              Map<String, String?> userDetails = await getUser();
              var flagId = ''.obs;
              if (userDetails['country'] == 'India') {
                flagId.value = '0';
              } else if (userDetails['country'] == 'Nepal') {
                flagId.value = '1';
              } else if (userDetails['country'] == 'Sri lanka') {
                flagId.value = '2';
              } else if (userDetails['country'] == 'Bangladesh') {
                flagId.value = '3';
              } else if (userDetails['country'] == 'Bhutan') {
                flagId.value = '4';
              }

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseSessionScreen(
                  country: flagId.value,
                  titleOfCourse: cata['categorytitle'],
                );
              }));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blueGrey.shade100
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.all(screenWidth * 0.008), // Dynamic padding
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          cata['categoryimage'],
                          fit: BoxFit.cover,
                          height: screenHeight * 0.12, // 12% of screen height
                          width: screenHeight * 0.12, // 12% of screen height
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: CustomText(
                    text: cata['categorytitle'],
                    textalign: TextAlign.center,
                    textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize:
                            screenHeight * 0.015), // 1.5% of screen height
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: category.length,
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
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04), // 4% horizontal padding
          child: GestureDetector(
            onTap: () async {
              homeScreenController.changecategoryIndexForColor(index);
              Map<String, String?> userDetails = await getUser();
              var flagId = ''.obs;
              if (userDetails['country'] == 'India') {
                flagId.value = '0';
              } else if (userDetails['country'] == 'Nepal') {
                flagId.value = '1';
              } else if (userDetails['country'] == 'Sri lanka') {
                flagId.value = '2';
              } else if (userDetails['country'] == 'Bangladesh') {
                flagId.value = '3';
              } else if (userDetails['country'] == 'Bhutan') {
                flagId.value = '4';
              }
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  //  homeScreenController.changecategoryIndexForColor(100);
                  return CourseSessionScreen(
                    country: flagId.value,
                    titleOfCourse: cata['categorytitle'],
                  );
                },
              ));
              Future.delayed(const Duration(milliseconds: 300), () {
                homeScreenController.changecategoryIndexForColor(100);
              });
            },
            child: Obx(
              () => Column(
                children: [
                  Card(
                    elevation: 2,
                    child: Container(
                      height: screenHeight * 0.09, // 9% of screen height
                      decoration: BoxDecoration(
                          gradient:
                              homeScreenController.categoryIndexForColor ==
                                      index
                                  ? const LinearGradient(colors: [
                                      Color.fromRGBO(0, 56, 255, 1),
                                      Color.fromRGBO(0, 224, 255, 1)
                                    ])
                                  : const LinearGradient(
                                      colors: [Colors.white, Colors.white]),
                          border: Border.all(width: .002),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
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
                                          : Colors
                                              .black), // 1.5% of screen height
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
                                            : const Color.fromRGBO(
                                                130,
                                                130,
                                                130,
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
                                            : const Color.fromRGBO(
                                                130,
                                                130,
                                                130,
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
                                            : const Color.fromRGBO(
                                                130,
                                                130,
                                                130,
                                                1)), // 1.5% of screen height
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          Obx(
                            () => AnimatedRotation(
                              turns: homeScreenController
                                      .getRotationState(index)
                                  ? 0
                                  : 0.25, // Rotate 180 degrees when expanded
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: GestureDetector(
                                  onTap: () async {
                                    homeScreenController.toggleExpansion(index);
                                    homeScreenController.course_section.clear();
                                    List<CourseSectionModel> fetchedSections =
                                        await academicCourseServices
                                            .fetchCoursesSection('0');
                                    log(fetchedSections.reversed.iterator
                                        .toString());
                                    // Step 4: Add the fetched data to the list
                                    homeScreenController.course_section
                                        .addAll(fetchedSections);
                                  },
                                  child: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                            ),
                          ),
                          // const Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (homeScreenController.isExpanded(index)) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        padding: const EdgeInsets.all(8.0),
                        height: screenHeight * 0.28,
                        width: screenWidth * .85, // Adjust based on content
                        // Optional background color for the list
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeScreenController.course_section
                              .length, // Number of items in the expandable list
                          itemBuilder: (context, subIndex) {
                            var course =
                                homeScreenController.course_section[subIndex];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CourseCategoryScreen(
                                              titleOfCategory:
                                                  course.sectionName,
                                              sectionId: course.sectionId),
                                    ));
                              },
                              child: ListTile(
                                leading: const Icon(Icons.book_rounded),
                                title: CustomText(text: course.sectionName),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget if not expanded
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: category.length,
    );
  }

///// loading shimmer for the category listview

  Widget shimerListviewOfCatefgory(
      {required double screenHeight, required double screenWidth}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 2,
              child: Container(
                height: screenHeight * 0.09,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.07,
                      width: screenHeight * 0.07,
                      color: Colors.grey[300],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.02,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.015,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    Container(
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
//////////////// Our statitics Text

  Widget ourStatisticsText(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.04, // 4% of screen width
        right: screenWidth * 0.04, // 4% of screen width
        top: screenHeight * 0.02, // 2% of screen height
      ),
      child: Stack(
        children: [
          CustomText(
            text: 'Our Statistics',
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: screenHeight * 0.02, // 2% of screen height
            ),
          ),
          Positioned(
            left: screenWidth * 0.16, // Adjusted for responsive width
            top: screenHeight * 0.025, // Adjusted for responsive height
            child: SizedBox(
              width: screenWidth * 0.16, // 16% of screen width
              child: Image.asset('lib/Assets/Onboard/image.png'),
            ),
          ),
        ],
      ),
    );
  }

//////////////// Our statitics sessions with four images

  Widget ourStatisticsSession(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.all(screenWidth * 0.04), // 4% padding of screen width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.16, // 16% of screen height
                        child: Image.asset('lib/Assets/Home/statitics-bg.png'),
                      ),
                      Positioned(
                        left: screenWidth * 0.07, // Responsive positioning
                        top: screenHeight * 0.03, // Responsive positioning
                        child: SizedBox(
                          height: screenHeight * 0.05, // Responsive height
                          child: Image.asset(
                              'lib/Assets/Home/statitics-video.png'),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: '27000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.022), // Responsive text size
                  ),
                  CustomText(
                    text: 'Video Classes',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.015), // Responsive text size
                  ),
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.16, // 16% of screen height
                        child: Image.asset('lib/Assets/Home/statitics-bg.png'),
                      ),
                      Positioned(
                        left: screenWidth * 0.07, // Responsive positioning
                        top: screenHeight * 0.03, // Responsive positioning
                        child: SizedBox(
                          height: screenHeight * 0.05, // Responsive height
                          child:
                              Image.asset('lib/Assets/Home/statitics-exam.png'),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: '62000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.022), // Responsive text size
                  ),
                  CustomText(
                    text: 'Questions Bank',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.015), // Responsive text size
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.all(screenWidth * 0.04), // 4% padding of screen width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.16, // 16% of screen height
                        child: Image.asset('lib/Assets/Home/statitics-bg.png'),
                      ),
                      Positioned(
                        left: screenWidth * 0.07, // Responsive positioning
                        top: screenHeight * 0.03, // Responsive positioning
                        child: SizedBox(
                          height: screenHeight * 0.05, // Responsive height
                          child: Image.asset(
                              'lib/Assets/Home/statitics-graduate.png'),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: '2,00,000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.022), // Responsive text size
                  ),
                  CustomText(
                    text: 'Students',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.015), // Responsive text size
                  ),
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.16, // 16% of screen height
                        child: Image.asset('lib/Assets/Home/statitics-bg.png'),
                      ),
                      Positioned(
                        left: screenWidth * 0.08, // Responsive positioning
                        top: screenHeight * 0.035, // Responsive positioning
                        child: SizedBox(
                          height: screenHeight * 0.045, // Responsive height
                          child: Image.asset(
                              'lib/Assets/Home/statitics-google.png'),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: '4.7/5',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.022), // Responsive text size
                  ),
                  CustomText(
                    text: 'Google Ratings',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.015), // Responsive text size
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

////////////////  Our cousrse and board text and Gird view list view Button

  Widget coursesBoardsAndGrid(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // 4% of screen width
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              CustomText(
                text: 'Courses & Boards',
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: screenHeight * 0.02, // 2% of screen height
                ),
              ),
              Positioned(
                left: screenWidth * 0.15, // Responsive positioning
                top: screenHeight * 0.025, // Responsive positioning
                child: SizedBox(
                  width: screenWidth * 0.26, // Responsive width
                  child: Image.asset('lib/Assets/Onboard/image.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget coursesAndBoardSession(double screenWidth, screenHeight) {
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
        } else {
          final category = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: gridOfcoursesAndBoardSession(
                category, screenWidth, screenHeight),
          );
        }
      },
    );
  }

  Widget gridOfcoursesAndBoardSession(
      List<dynamic> category, double screenWidth, screenHeight) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: const EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () async {
              homeScreenController.changecourseAndBoardIndexForColor(index);
              homeScreenController.changeisLoadingOfcourseSessionList(false);
              homeScreenController.courseSessionList.clear();
              Map<String, String?> userDetails = await getUser();
              var flagId = ''.obs;
              if (userDetails['country'] == 'India') {
                flagId.value = '0';
              } else if (userDetails['country'] == 'Nepal') {
                flagId.value = '1';
              } else if (userDetails['country'] == 'Sri lanka') {
                flagId.value = '2';
              } else if (userDetails['country'] == 'Bangladesh') {
                flagId.value = '3';
              } else if (userDetails['country'] == 'Bhutan') {
                flagId.value = '4';
              }
              var fetchedCourses = await academicCourseServices
                  .fetchCoursesSection(flagId.value);
              homeScreenController.changeCourseSessionList(fetchedCourses);
              homeScreenController.changeisLoadingOfcourseSessionList(true);
            },
            child: Obx(
              () => Card(
                elevation: 5,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: homeScreenController
                                    .courseAndBoardIndexForColor.value ==
                                index
                            ? const LinearGradient(
                                begin: Alignment
                                    .topCenter, // Start from the top center
                                end: Alignment.bottomCenter,
                                colors: [
                                    Color.fromRGBO(0, 56, 255, 1),
                                    Color.fromRGBO(0, 224, 255, 1)
                                  ])
                            : const LinearGradient(
                                begin: Alignment
                                    .topCenter, // Start from the top center
                                end: Alignment.bottomCenter,
                                colors: [Colors.white, Colors.white]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Center(
                        child: CustomText(
                          text: cata['categorytitle'],
                          maxline: 2,
                          textStyle: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: homeScreenController
                                          .courseAndBoardIndexForColor.value ==
                                      index
                                  ? Colors.white
                                  : Colors.black),
                          textalign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        );
      },
      itemCount: category.length,
    );
  }

  Widget listOfgridOfcoursesAndBoardSession() {
    log('the on the home screen is showing at fist like this ${homeScreenController.courseSessionList.toList()}');
    return Obx(() => homeScreenController.courseSessionList.isEmpty
            ? CustomText(text: 'list is empty')
            : homeScreenController.isLoadingOfcourseSessionList.value == true
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var course =
                          homeScreenController.courseSessionList[index];

                      return GestureDetector(
                        onTap: () async {
                          homeScreenController
                              .changeIsLoadingcourseCategoryModel(true);
                          // log(homeScreenController
                          //     .isLoadingcoursecategoryModel.value
                          //     .toString());

                          List<CourseCategoryModel> courseCategoryModel =
                              await academicCourseServices
                                  .fetchCoursesCategory(course.sectionId);
                          homeScreenController
                              .changecategoryIndexForColor(index);
                          Future.delayed(const Duration(milliseconds: 300), () {
                            homeScreenController
                                .changecategoryIndexForColor(100);
                          });
                          homeScreenController
                              .changeIsLoadingcourseCategoryModel(false);
                          log(homeScreenController
                              .isLoadingcoursecategoryModel.value
                              .toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseCategoryScreen(
                                  titleOfCategory: course.sectionName,
                                  sectionId: course.sectionId,
                                ),
                              ));
                          log('isLoadingcourseCategoryModel changed: ${homeScreenController.isLoadingcoursecategoryModel.value}');
                        },
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: homeScreenController
                                                .categoryIndexForColor.value ==
                                            index
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
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
                                        width: 260,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              CustomText(
                                                text: course
                                                    .sectionName, // Use original text if translation fails
                                                textStyle: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: homeScreenController
                                                              .categoryIndexForColor
                                                              .value ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                maxline: 1,
                                              ),
                                            ],
                                          ),
                                        )),
                                    const Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: homeScreenController.courseSessionList.length,
                  )
                : customShimmerBuilder(
                    width: 350,
                    height: 60,
                    builderLength: 10) // Show a message if the list is empty

        );
  }

  Widget ourProFeautureText(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * .03,
          left: screenWidth * .04,
          right: screenWidth * .04),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'Our Pro Features',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.15, // Responsive positioning
                    top: screenHeight * 0.025, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.26, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
              height: screenHeight * .3,
              child: Image.asset('lib/Assets/Home/pro-feature-img.png')),
        ],
      ),
    );
  }

  Widget andTheFollowingFeaturesSession(double screenHeight, screenWidth) {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: EdgeInsets.only(
                left: screenWidth * .02, right: screenWidth * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    CustomText(
                      text: 'And The Following Features',
                      textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.04, // 2% of screen height
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.15, // Responsive positioning
                      top: screenHeight * 0.042, // Responsive positioning
                      child: SizedBox(
                        width: screenWidth * 0.15, // Responsive width
                        child: Image.asset('lib/Assets/Onboard/image.png'),
                      ),
                    ),
                  ],
                ),
                homeScreenController.andTheFollowingFeaturesListOrGrid.value
                    ? IconButton(
                        onPressed: () {
                          homeScreenController
                              .changeandTheFollowingFeaturesListOrGrid(false);
                        },
                        icon: const Icon(Icons.grid_view_outlined),
                      )
                    : IconButton(
                        onPressed: () {
                          homeScreenController
                              .changeandTheFollowingFeaturesListOrGrid(true);
                        },
                        icon: const Icon(Icons.list),
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 8, top: 8, bottom: 8),
          child: SizedBox(
            // height: screenHeight * .3,
            child:
                Image.asset('lib/Assets/Home/and-following-features-image.png'),
          ),
        )
      ],
    );
  }

  Widget differentModeOfLearningSession(double screenHeight, screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * .03,
          left: screenWidth * .02,
          right: screenWidth * .02),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'Different Modes of Learning',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.04, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.15, // Responsive positioning
                    top: screenHeight * 0.040, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.15, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> _fetchModesOfLearning() async {
    try {
      final Map<String, dynamic> jsonData =
          json.decode(differentModesOfLearningJson);
      return jsonData['differentModes'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Widget differentModeOfLearningBuilder(double screenHeight, screenWidth) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchModesOfLearning(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Modes of Learning.'));
        } else {
          final modesOfLearning = snapshot.data!;
          return SizedBox(
            height: screenHeight * .4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modesOfLearning.length,
              itemBuilder: (context, index) {
                var learninMode = modesOfLearning[index];
                return _cardForModeOfLearning(
                    learninMode, screenHeight, screenWidth);
              },
            ),
          );
        }
      },
    );
  }

  Widget _cardForModeOfLearning(
      dynamic learninMode, double screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(24))),
          height: screenHeight * 3,
          width: screenWidth * .57,
          child: Padding(
            padding: EdgeInsets.all(screenHeight * .02),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * .09,
                  width: screenWidth * .3,
                  child: Image.asset(
                    learninMode['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomText(
                          // textalign: TextAlign.center,
                          text: learninMode['title'],
                          textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                SizedBox(
                  height: screenHeight * .12,
                  child: SingleChildScrollView(
                    child: CustomText(
                        maxline: 9,
                        textalign: TextAlign.center,
                        text: learninMode['describtion'],
                        textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: const Color.fromRGBO(87, 92, 116, 1))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .015,
                ),
                Container(
                  height: screenHeight * .028,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(0, 56, 255, 1),
                        Color.fromRGBO(0, 224, 255, 1)
                      ])),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          text: learninMode['buttonText'],
                          textStyle: GoogleFonts.mulish(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12),
                        ),
                        Container(
                            height: screenHeight * .023,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors
                                    .white, // Set the border color to white
                                width: 4, // Set the border width
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 8,
                              child: Icon(
                                Icons.play_arrow,
                                size: 11,
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget yourLearningYourLanguageSession(double screenHeight, screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * .03,
          left: screenWidth * .02,
          right: screenWidth * .02),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'Your Learning, Your Language',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.50, // Responsive positioning
                    top: screenHeight * 0.023, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.23, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * .03,
          ),
          CustomText(
            text:
                'Interactive recorded self-paced courses in multiple languages, with more coming soon!',
            textStyle:
                GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
            textalign: TextAlign.left,
          ),
          SizedBox(
            height: screenHeight * .015,
          )
        ],
      ),
    );
  }

  Future<List<dynamic>> _fetchCountryJson() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(countriesJson);
      return jsonData['countries'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Widget countryBuilder(
    double screenWidth,
    double screenHeight,
  ) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchCountryJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No country available.'));
        } else {
          final category = snapshot.data!;
          return countyJsonCard(
            category,
            screenWidth,
            screenHeight,
          );
        }
      },
    );
  }

//// Grid view Of the Fetched Categories

////////////////   List view of the Fetched Categorires

  Widget countyJsonCard(
    List<dynamic> category,
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var _country = category[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04), // 4% horizontal padding
              child: GestureDetector(
                onTap: () {
                  _country['name'] == 'India'
                      ? homeScreenController.changelanguageListVisibility(true)
                      : homeScreenController
                          .changelanguageListVisibility(false);
                },
                child: Card(
                  elevation: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 59,
                            width: 69,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(
                                _country['image'],
                                fit: BoxFit.cover,
                              ),
                            )),
                        CustomText(
                          text: _country['name'],
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          textStyle: GoogleFonts.mulish(),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
        itemCount: category.length,
      ),
    );
  }

  Widget homeScreenlanguageList(
      BuildContext context, double screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Obx(
        () => Visibility(
          visible: homeScreenController.languageListVisibility.value,
          child: Card(
            elevation: 3,
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                height: screenHeight * 0.2,
                width: screenWidth * 0.8, // 50% of the screen height
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: indianLanguages.length,
                    itemBuilder: (context, index) {
                      final language = indianLanguages[index];
                      bool isSelected =
                          languageController.currentLocale.value.languageCode ==
                              language["code"];
                      return GestureDetector(
                          onTap: () {
                            homeScreenController
                                .changelanguageListVisibility(false);
                            languageController.changeLanguage(
                                language["code"]!, language["country"]!);
                            log(languageController.currentLocale.value
                                .toString());
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight *
                                      0.01), // 1% of screen height
                              child: Container(
                                  height: screenHeight *
                                      0.045, // 5% of screen height
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenHeight *
                                          0.02), // 2% of screen height
                                  decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color.fromRGBO(
                                              239, 246, 255, 1)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                right: screenHeight *
                                                    0.02), // 2% of screen height
                                            child: Container(
                                                width: screenHeight *
                                                    0.025, // 2.5% of screen height
                                                height: screenHeight *
                                                    0.025, // 2.5% of screen height
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1)),
                                                child: Padding(
                                                    padding: EdgeInsets.all(
                                                        screenHeight *
                                                            0.005), // 0.5% of screen height
                                                    child: CircleAvatar(
                                                        radius: screenHeight *
                                                            0.0125, // 1.25% of screen height
                                                        backgroundColor: isSelected
                                                            ? const Color
                                                                .fromARGB(
                                                                255, 9, 97, 245)
                                                            : Colors
                                                                .transparent)))),
                                        Text(language["language"]!,
                                            style: GoogleFonts.lato(
                                                fontSize: screenHeight *
                                                    0.02) // 2% of screen height
                                            )
                                      ]))));
                    })),
          ),
        ),
      ),
    );
  }

  Widget continueWatching(double screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'continue watching',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.20, // Responsive positioning
                    top: screenHeight * 0.023, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.23, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          SizedBox(
            height: screenHeight * .2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: screenHeight * .2,
                    width: screenWidth * .6,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ourExpertsSession(double screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'Our Experts',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.10, // Responsive positioning
                    top: screenHeight * 0.023, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.23, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          SizedBox(
            height: screenHeight * .241,
            child: FutureBuilder<List<FacultyModel>>(
              future: homeScreenServices.fetchFaculities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is loading, show a loading indicator
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there is an error, show an error message
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // If no data is available
                  return const Center(child: Text('No Experts Available'));
                } else {
                  // Once data is available, display the list
                  List<FacultyModel> facultyList = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: facultyList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth *
                            0.01), // Dynamic padding (1% of screen width)
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Gradient border
                            Container(
                              height: screenHeight *
                                  0.31, // Dynamic height for border (31% of screen height)
                              width: screenWidth *
                                  0.6, // Dynamic width for border (60% of screen width)
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(30, 117, 229, 1),
                                    Color.fromRGBO(90, 203, 255, 1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    screenWidth *
                                        0.03)), // Dynamic border radius
                              ),
                            ),
                            // Original container
                            Container(
                              height: screenHeight *
                                  0.227, // Dynamic height (22.7% of screen height)
                              width: screenWidth *
                                  0.58, // Dynamic width (58% of screen width)
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    screenWidth *
                                        0.03)), // Dynamic border radius
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: screenHeight *
                                          0.0045), // Dynamic vertical spacing
                                  CircleAvatar(
                                    radius: screenWidth *
                                        0.13, // Dynamic radius (15% of screen width)
                                    backgroundColor:
                                        const Color.fromRGBO(206, 211, 214, 1),
                                    child: ClipOval(
                                      child: Image.network(
                                        facultyList[index].photo ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Icon(
                                            Icons
                                                .person_2_outlined, // Fallback icon
                                            size: screenWidth *
                                                0.1, // Dynamic size for fallback icon (10% of screen width)
                                            color: Colors.white, // Icon color
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: screenHeight *
                                          0.005), // Dynamic vertical spacing
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth *
                                              0.02), // Dynamic horizontal padding
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: facultyList[index]
                                                    .facultyName ??
                                                '',
                                            textStyle: GoogleFonts.poppins(
                                              color: const Color.fromRGBO(
                                                  27, 73, 101, 1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth *
                                                  0.04, // Dynamic font size (4% of screen width)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: screenHeight *
                                          0.003), // Dynamic vertical spacing
                                  CustomText(
                                    text:
                                        facultyList[index].qualification ?? '',
                                    textStyle: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(
                                          188, 189, 189, 1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth *
                                          0.02, // Dynamic font size (2% of screen width)
                                    ),
                                    textalign: TextAlign.center,
                                  ),
                                  CustomText(
                                    text: facultyList[index].language ?? '',
                                    textStyle: GoogleFonts.poppins(
                                      color:
                                          const Color.fromRGBO(27, 73, 101, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth *
                                          0.04, // Dynamic font size (4% of screen width)
                                    ),
                                  ),
                                  SizedBox(
                                      height: screenHeight *
                                          0.01), // Dynamic vertical spacing
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget successFullLeanersSession(
      {required double screenHeight, required double screenWidth}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CustomText(
                    text: 'Success full Learner ',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.25, // Responsive positioning
                    top: screenHeight * 0.023, // Responsive positioning
                    child: SizedBox(
                      width: screenWidth * 0.23, // Responsive width
                      child: Image.asset('lib/Assets/Onboard/image.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          sucessFullLeanersBuilder(screenWidth, screenHeight)
        ],
      ),
    );
  }

  Future<List<dynamic>> _fetchsucessFullLeanersJson() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(sucessFullLeanersJson);
      return jsonData['sucessFullLeaners'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Widget sucessFullLeanersBuilder(
    double screenWidth,
    double screenHeight,
  ) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchsucessFullLeanersJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No sucessfull Leaners available.'));
        } else {
          final sucessFullLeaners = snapshot.data!;
          return sucessFullLeanersJsonCard(
            sucessFullLeaners,
            screenWidth,
            screenHeight,
          );
        }
      },
    );
  }

////////////////   caard of sucessFullLeaners

  Widget sucessFullLeanersJsonCard(
    List<dynamic> sucessFullLeaners,
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight * .2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var sucessFullLeaner = sucessFullLeaners[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(19),
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                    bottomLeft: Radius.circular(3),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(155, 243, 255, 1),
                      Color.fromRGBO(30, 117, 229, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                      3.0), // Padding for the gradient border
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, // The content's background
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 280,
                            child: CustomText(
                              text: sucessFullLeaner['describtion'],
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * .03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage(sucessFullLeaner['image']),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: sucessFullLeaner['name'],
                                    textStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  CustomText(
                                    text: sucessFullLeaner['position'],
                                    textStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color.fromRGBO(
                                          108, 114, 117, 1),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: sucessFullLeaners.length,
      ),
    );
  }

  Future<List<dynamic>> _fetchSocialMediasJson() async {
    try {
      final Map<String, dynamic> jsonData = json.decode(socialMediaJson);
      return jsonData['socialMedia'];
    } catch (e) {
      throw Exception('Failed to load social medias: $e');
    }
  }

  Widget socialMediasBuilder({
    required double screenWidth,
    required double screenHeight,
  }) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchSocialMediasJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No social media available.'));
        } else {
          final socialMedias = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                socialMediaCard(socialMedias[0]),
                socialMediaCard(socialMedias[1]),
                socialMediaCard(socialMedias[2]),
                socialMediaCard(socialMedias[3]),
              ],
            ),
          );
        }
      },
    );
  }

  Widget socialMediaCard(var socialMedia) {
    return GestureDetector(
      onTap: () {
        var url = Uri.parse(socialMedia['link']);
        launchUrl(url);
      },
      child: Card(
        child: SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: Image.asset(
                socialMedia['image'],
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Widget visitOutWebSiteText() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              var url = Uri.parse('https://www.thelearnyn.com');
              launchUrl(url);
            },
            child: CustomText(
              text: 'Also_Vist_Our_Website_www.Thelearnyn.Com',
              textStyle: GoogleFonts.mulish(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
