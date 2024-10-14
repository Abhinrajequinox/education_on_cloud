import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/chapter_screen_controller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/course_screen_controller.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterScreenWidget {
  final ChapterScreenController chapterScreenController =
      ChapterScreenController();
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
      required double screenWidth}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var chapter = chapters[index];
        var cardColor = rainbowColors[index % rainbowColors.length];
        return Card(
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: cardColor, width: 3)),
              image: const DecorationImage(
                  image: AssetImage(
                      'lib/Assets/Home/chapter-screen-background-image.png'),
                  fit: BoxFit.cover,
                  opacity: .4),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            height: screenHeight * .09,
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
                    child: CustomText(
                      maxline: 1,
                      text: '${index + 1} . ${chapter.chapterName}',
                      textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .03,
                  ),
                  Container(
                    width: screenWidth * .25,
                    height: screenHeight * .03,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                  // const ImageIcon(
                  //     AssetImage('lib/Assets/Icons/arrow-circle-up.png')),
                  Obx(
                    ()=> AnimatedRotation(
                      // Rotate by 180 degrees (pi radians) when toggled
                      turns: chapterScreenController.toggleanimation[index] ?? false
                        ? 0
                        : 0.5, // 0 means no rotation, 0.5 is 180 degrees
                      duration:
                          const Duration(milliseconds: 300), // Animation duration
                      curve: Curves
                          .easeInOut, // Animation curve for smooth transition
                      child: GestureDetector(
                        onTap: () {

                          chapterScreenController.toggleExpansion(index);
                        },
                        child: const ImageIcon(AssetImage(
                              'lib/Assets/Icons/arrow-circle-up.png')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: chapters.length,
    );
  }
}
