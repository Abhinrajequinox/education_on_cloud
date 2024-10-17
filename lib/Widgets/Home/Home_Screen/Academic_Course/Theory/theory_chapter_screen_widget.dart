import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/theory_chapter_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Theory/theory_classes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class TheoryChaptersScreenWidget {
  // List<AcademicTheoryClassModel> theoryClass = [];
  final TheoryChapterScreenController theorychapterScreenController =
      TheoryChapterScreenController();
  final AcademicCourseServices academicCourseServices =
      AcademicCourseServices();
  Widget titleAndBackButton(
      BuildContext context, double screenWidth, String titleOfChapter) {
    return SingleChildScrollView(
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
              width: screenWidth * .7,
              child: CustomText(
                text: titleOfChapter,
                maxline: 2,
                textalign: TextAlign.start,
                textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
            )
          ]),
          Row(
            children: [
              SizedBox(width: screenWidth * .102),
              SizedBox(
                width: screenWidth * .7,
                child: CustomText(
                    text: '$titleOfChapter Theory Classes',
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: primarycolour,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget listOfChapters(
      {required List<ChapterModel> chapters,
      required double screenHeight,
      required double screenWidth,
      required String languageName}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var chapter = chapters[index];
        var cardColor = rainbowColors[index % rainbowColors.length];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcademicCourseTheoryClass(
                            languageName: languageName,
                            chapterId: chapter.id,
                            titleName: chapter.chapterName,
                            cardColor: cardColor),
                      ));
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: cardColor, width: 3)),
                      image: const DecorationImage(
                          image: AssetImage(
                              'lib/Assets/Home/chapter-screen-background-image.png'),
                          fit: BoxFit.cover,
                          opacity: .4),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    height: screenHeight * .07,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: screenHeight * .04,
                            child: Image.network(
                                'https://thelearnyn1.s3.ap-south-1.amazonaws.com/chap_imgs/chap_imgs/${chapter.chapterIcon}'),
                          ),
                          SizedBox(
                            width: screenWidth * .03,
                          ),
                          SizedBox(
                            width: screenWidth * .32,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomText(
                                    maxline: 1,
                                    text:
                                        '${index + 1} . ${chapter.chapterName}',
                                    textStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * .03,
                          ),
                          Container(
                            width: screenWidth * .25,
                            height: screenHeight * .03,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromRGBO(30, 117, 229, 1)),
                            child: Center(
                              child: CustomText(
                                text: 'Go to Class',
                                textStyle: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Obx(
                            () => AnimatedRotation(
                              turns: theorychapterScreenController
                                      .getRotationState(index)
                                  ? 0
                                  : 0.5, // Rotate 180 degrees when expanded
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: GestureDetector(
                                onTap: () async {
                                  theorychapterScreenController
                                      .toggleExpansion(index);
                                                              },
                                child: const ImageIcon(
                                  AssetImage(
                                      'lib/Assets/Icons/arrow-circle-up.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (theorychapterScreenController.isExpanded(index)) {
                log(chapter.id);
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  height: screenHeight * 0.33,
                  width: screenWidth * 0.9, // Adjust based on content
                  child: Card(
                    elevation: 3,
                    child: FutureBuilder<List<ChapterSubTopicModel>>(
                      future: academicCourseServices.fetchTheorySubTopics(
                          chaptrId:
                              chapter.id), // Pass the appropriate chapter ID
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for the future to complete, show a loading indicator
                          return shimmerSubTopics(screenHeight, screenWidth);
                        } else if (snapshot.hasError) {
                          // If there's an error, display an error message
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          // If there's no data or the data is empty, show a message
                          return const Center(
                              child: Text('No subtopics found'));
                        } else {
                          // When data is successfully fetched, display it in a ListView
                          final subTopics = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: subTopics.length,
                            itemBuilder: (context, subIndex) {
                              var subTopic = subTopics[subIndex];
                              return ListTile(
                                leading: SizedBox(
                                  height: screenHeight * 0.02,
                                  child: Image.asset(
                                      'lib/Assets/Home/sub-topic-book-img.png'),
                                ),
                                title: CustomText(
                                  text:
                                      '1.${subIndex + 1}:  ${subTopic.subTopic}',
                                  textStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: Colors.black),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                );
              } else {
                return const SizedBox
                    .shrink(); // Return an empty widget if not expanded
              }
            }),
          ],
        );
      },
      itemCount: chapters.length,
    );
  }

  Widget shimmerSubTopics(double screenHeight, double screenWidth) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Number of shimmer items
      itemBuilder: (context, subIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: SizedBox(
                height: screenHeight * 0.02,
                child: Container(
                  width: 40, // Adjust width for the placeholder image
                  color: Colors.grey[300], // Placeholder for image
                ),
              ),
              title: Container(
                height: 15, // Height for the text placeholder
                width:
                    screenWidth * 0.5, // Adjust width for the placeholder text
                color: Colors.grey[300], // Placeholder for text
              ),
            ),
          ),
        );
      },
    );
  }

 
}
