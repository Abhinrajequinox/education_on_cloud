import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/home_screen_controller.dart';
import 'package:education_on_cloud/Utilities/home_screen_utilities.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenWidgets {
  final HomeScreenController homeScreenController = HomeScreenController();
  Widget coursePlans() {
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
                    height: 210,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    viewportFraction: 1,
                    initialPage: 0,
                    scrollDirection: Axis.horizontal),
                itemBuilder: (context, index, realIndex) {
                  final plan = plans[index];
                  return cardForPlan(plan);
                });
          }
        });
  }

  Widget cardForPlan(dynamic plan) {
    return Card(
        color: const Color.fromRGBO(27, 40, 63, 1),
        margin: const EdgeInsets.all(15),
        child: Container(
            width: 390,
            padding: const EdgeInsets.all(13),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    CustomText(
                        text: plan['plantitle'],
                        textStyle: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                    const SizedBox(height: 8),
                    SizedBox(
                        width: 210,
                        child: CustomText(
                            textalign: TextAlign.left,
                            text: plan['plandetails'],
                            textStyle: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 10))),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () => _launchURL(plan['planlink']),
                        child: Container(
                            width: 110,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                          text: 'Explore Now',
                                          textStyle: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 8.11)),
                                      const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 15,
                                          child: Icon(Icons.play_circle_outline,
                                              color: Colors.blue, size: 15))
                                    ]))))
                  ])),
              Image.asset(plan['planimage'])
            ])));
  }

  Future<List<dynamic>> _fetchPlans() async {
    try {
      // Decode JSON string
      final Map<String, dynamic> jsonData = json.decode(plansJson);
      return jsonData['plans'];
    } catch (e) {
      throw Exception('Failed to load plans: $e');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget categoryAndGrid() {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Obx(
          () =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Stack(children: [
              CustomText(
                  text: 'Category',
                  textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              Positioned(
                  left: 20,
                  top: 20,
                  child: SizedBox(
                      width: 60,
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
          ]),
        ));
  }

  Widget searchCourse() {
    return Padding(
      padding: const EdgeInsets.all(15),
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

  Future<List<dynamic>> _fetchCategory() async {
    try {
      // Decode JSON string
      final Map<String, dynamic> jsonData = json.decode(categoryJson);
      return jsonData['category'];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Widget categoryBuilder() {
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
          return Obx(
            () => homeScreenController.categoryListOrGrid.value
                ? listviewOfCategory(category)
                : gridViewOfCategory(category),
          );
        }
      },
    );
  }

  Widget gridViewOfCategory(List<dynamic> category) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blueGrey.shade100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
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
                        height: 95,
                        width: 95,
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
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
              )
            ],
          ),
        );
      },
      itemCount: category.length,
    );
  }

  Widget listviewOfCategory(List<dynamic> category) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var cata = category[index];
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Card(
            elevation: 2,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                  border: Border.all(width: .002),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 55,
                      width: 55,
                      child: Image.asset(cata['categoryimage'])),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: cata['categorytitle'],
                        textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 18),
                          CustomText(
                            text: cata['categoryrating'],
                            textStyle: GoogleFonts.inter(
                                color: const Color.fromRGBO(130, 130, 130, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          CustomText(
                            text: cata['categorystd'],
                            textStyle: GoogleFonts.inter(
                                color: const Color.fromRGBO(130, 130, 130, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          CustomText(
                            text: cata['categorycourse'],
                            textStyle: GoogleFonts.inter(
                                color: const Color.fromRGBO(130, 130, 130, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
          ),
        );
      },
      itemCount: category.length,
    );
  }

  Widget ourStatisticsText() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Stack(children: [
        CustomText(
          text: 'Our Statistics',
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: SizedBox(
            width: 60,
            child: Image.asset('lib/Assets/Onboard/image.png'),
          ),
        )
      ]),
    );
  }

  Widget ourStatisticsSession() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomText(
                    text: '27000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  CustomText(
                    text: 'Video Classes',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text: '62000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  CustomText(
                    text: 'Questions Bank',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
         padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomText(
                    text: '2,00,000+',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  CustomText(
                    text: 'Students',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text: '4.7/5',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  CustomText(
                    text: 'Google Ratings',
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget coursesBoardsAndGrid() {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Obx(
          () =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Stack(children: [
              CustomText(
                  text: 'Courses & Boards',
                  textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              Positioned(
                  left: 58,
                  top: 19,
                  child: SizedBox(
                      width: 100,
                      child: Image.asset('lib/Assets/Onboard/image.png')))
            ]),
            homeScreenController.coursesBoardsListOrGrid.value
                ? IconButton(
                    onPressed: () {
                      homeScreenController.changeCoursesBoardsListOrGrid(false);
                    },
                    icon: const Icon(Icons.grid_view_outlined))
                : IconButton(
                    onPressed: () {
                      homeScreenController.changeCoursesBoardsListOrGrid(true);
                    },
                    icon: const Icon(Icons.list))
          ]),
        ));
  }
}
