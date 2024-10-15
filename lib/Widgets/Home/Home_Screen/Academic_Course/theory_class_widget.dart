import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicTheoryClassWidget {
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
                    text: '$titleOfChapter Theory Class',
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

  Widget listOfClass(
      {required List<AcademicTheoryClassModel> classes,
      required double screenHeight,
      required double screenWidth,
      required String languageName,
      required String titleOfClass,
      required Color cardColor}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var theoryClass = classes[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () async {
                  // List<AcademicTheoryClassModel> theoryClass =
                  //     await academicCourseServices.fetchAcademicTheoryClass(
                  //         chaptId: chapter.id, language: languageName);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AcademicCourseTheoryClass(
                  //         theoryClass: theoryClass,titleName: chapter.chapterName,
                  //       ),
                  //     ));
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
                    height: screenHeight * .09,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              width: screenWidth * .2,
                              child: Image.asset(
                                  'lib/Assets/Home/video-thumbnail-img.png'),
                            ),
                            SizedBox(
                              width: screenWidth * .02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth * .6,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: titleOfClass,
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
                                  height: screenHeight * 0.01,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Theory - ${theoryClass.part}',
                                      textStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: const Color.fromRGBO(
                                              0, 56, 255, 1)),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .07,
                                    ),
                                    Container(
                                      width: screenWidth * .23,
                                      height: screenHeight * .025,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color:
                                              Color.fromRGBO(30, 117, 229, 1)),
                                      child: Center(
                                        child: CustomText(
                                          text: 'Go to Class',
                                          textStyle: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: classes.length,
    );
  }
}
