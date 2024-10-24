import 'package:education_on_cloud/Models/Home/Academic_Course/quick_tips_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Quick_Tips/quick_tips_video_class_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicQuickTipsChapterScreenWidget {
 
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
                    text: '$titleOfChapter - Quick Tips',
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

  Widget listOfChapters({
    required List<AcademicQuickTipsModelClass> chapters,
    required double screenHeight,
    required double screenWidth,
    required String languageName,
    required String courseId,
    required String titleOfChapter,
  }) {
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
                        builder: (context) => AcademicQuickTipsVideoClassScreen(
                            courseId: courseId,
                            titleOfChapter: titleOfChapter,
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
                            height: screenHeight * .03,
                            child: Image.asset(
                                'lib/Assets/Home/Drawer_icon/quick-tip-img-icon.png'),
                          ),
                          SizedBox(
                            width: screenWidth * .02,
                          ),
                          SizedBox(
                            width: screenWidth * .39,
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
                            width: screenWidth * .28,
                            height: screenHeight * .03,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromRGBO(30, 117, 229, 1)),
                            child: Center(
                              child: CustomText(
                                text: 'Quick Tips',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: chapters.length,
    );
  }
}
