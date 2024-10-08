import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/home_screen_services.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:education_on_cloud/Utilities/Home/home_screen_utilities.dart';
import 'package:education_on_cloud/Views/Screens/Home/course_category_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/course_session_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenWidgets {
  final HomeScreenController homeScreenController = HomeScreenController();
  final HomeScreenServices homeScreenServices = HomeScreenServices();

  // Course Plans

  Widget coursePlans(double screenWidth, double screenHeight) {
    return FutureBuilder<List<dynamic>>(
        future: _fetchPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
          return const Center(child: CircularProgressIndicator());
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
              List<CourseSectionModel> _course_section =
                  await homeScreenServices.fetchCoursesSection('0');
              // log(_course_section.toString());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //  homeScreenController.changecategoryIndexForColor(100);
                return CourseSessionScreen(
                  courseSectionModel: _course_section,
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
              List<CourseSectionModel> _course_section =
                  await homeScreenServices.fetchCoursesSection('0');
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
      child: Obx(
        () => Row(
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
            homeScreenController.coursesBoardsListOrGrid.value
                ? IconButton(
                    onPressed: () {
                      homeScreenController.changeCoursesBoardsListOrGrid(false);
                    },
                    icon: const Icon(Icons.grid_view_outlined),
                  )
                : IconButton(
                    onPressed: () {
                      homeScreenController.changeCoursesBoardsListOrGrid(true);
                    },
                    icon: const Icon(Icons.list),
                  ),
          ],
        ),
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
            padding: const EdgeInsets.only(left: 15, right: 15),
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
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () async {
              homeScreenController.changecourseAndBoardIndexForColor(index);
              homeScreenController.courseSessionList.clear();
              var fetchedCourses =
                  await homeScreenServices.fetchCoursesSection('0');
              homeScreenController.changeCourseSessionList(fetchedCourses);
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
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var course = homeScreenController.courseSessionList[index];
          return GestureDetector(
            onTap: () async {
              List<CourseCategoryModel> courseCategoryModel =
                  await homeScreenServices
                      .fetchCoursesCategory(course.sectionId);
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
              () => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            homeScreenController.categoryIndexForColor.value ==
                                    index
                                ? Colors.blue
                                : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
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
                            color: homeScreenController
                                        .categoryIndexForColor.value ==
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
            ),
          );
        },
        itemCount: homeScreenController.courseSessionList.length,
      ),
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
                CustomText(
                    textalign: TextAlign.center,
                    text: learninMode['title'],
                    textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration: TextDecoration.underline)),
                SizedBox(
                  height: screenHeight * .02,
                ),
                CustomText(
                    maxline: 7,
                    textalign: TextAlign.center,
                    text: learninMode['describtion'],
                    textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: const Color.fromRGBO(87, 92, 116, 1))),
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
                GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
            textalign: TextAlign.left,
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
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var _country = category[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04), // 4% horizontal padding
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 0,
                  child: Container(
                    // width: screenWidth*0.2,
                    // height: screenHeight * 0.05, // 9% of screen height
                    decoration: BoxDecoration(
                        border: Border.all(width: .002),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 59,
                            width: 80,
                            child: Image.asset(
                              _country['image'],
                              fit: BoxFit.cover,
                            )),
                        CustomText(
                          text: _country['name'],
                          fontWeight: FontWeight.w700,
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
}
