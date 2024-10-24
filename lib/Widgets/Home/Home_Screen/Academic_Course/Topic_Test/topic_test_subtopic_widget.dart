import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/topic_test_services.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/topic_test_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicTopicTestSubTopicScreenWidget {
  final AcdemicTopicTestServices acdemicTopicTestServices =
      AcdemicTopicTestServices();
  Widget titleAndBackButton(BuildContext context, double screenWidth,
      String titleOfChapter, titleName) {
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
                    text: '$titleName - Topic Test',
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
      {required List<AcademicTopicTestSubTopicModel> chapters,
      required double screenHeight,
      required double screenWidth,
      required String languageName,
      required String courseId,
      required String titleOfChapter,
      required String chapterIcon,
      required String chapterId,
      required Color cardColor}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var chapter = chapters[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AcademicQuickTipsVideoClassScreen(
                  //           courseId: courseId,
                  //           titleOfChapter: titleOfChapter,
                  //           languageName: languageName,
                  //           chapterId: chapter.id,
                  //           titleName: chapter.chapterName,
                  //           cardColor: cardColor),
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
                    height: screenHeight * .07,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: screenHeight * .04,
                            child: Image.network(
                                'https://thelearnyn1.s3.ap-south-1.amazonaws.com/chap_imgs/chap_imgs/$chapterIcon'),
                          ),
                          SizedBox(
                            width: screenWidth * .25,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomText(
                                    maxline: 1,
                                    text: '${index + 1} . ${chapter.subTopics}',
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
                            width: screenWidth * .005,
                          ),
                          markWidget(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              topicId: chapter.id,
                              courseId: courseId,
                              chapterId: chapterId),
                          SizedBox(
                            width: screenWidth * .005,
                          ),
                          Container(
                            width: screenWidth * .22,
                            height: screenHeight * .03,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromRGBO(30, 117, 229, 1)),
                            child: Center(
                              child: CustomText(
                                text: 'Topic',
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

  Widget buildProgress(double mark) {
  // Calculate the percentage and convert it to an int
  int percentage = (mark * 100).toInt(); // Using toInt() for floor value
  // Alternatively, you can use round() if you want to round to the nearest integer
  // int percentage = ((mark * 100).round());

  return CustomText(
    text: '$percentage %', // Display the integer value as a percentage
    textStyle: GoogleFonts.kadwa(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: const Color.fromRGBO(30, 117, 229, 1),
    ),
  );
}


  Widget markWidget(
      {required double screenHeight,
      required double screenWidth,
      required String topicId,
      required String courseId,
      required String chapterId}) {
    return FutureBuilder<AcdemicTopicTestFetchScoreCardModel?>(
        future: acdemicTopicTestServices.fetchScoreCard(
          courseId: courseId,
          mobileNumber: '8592943588',
          topicId: topicId,
        ),
        builder: (context, snapshot) {
          // Handle different states of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a loading indicator
            return Padding(
              padding: EdgeInsets.all(screenWidth * .05),
              child: const SizedBox.shrink(),
            );
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            // If there's no data or the data is empty, show a message
            return const SizedBox.shrink();
          } else {
            var scoreCard = snapshot.data;
            var mark = double.parse(scoreCard!.score);
            return TweenAnimationBuilder(
              duration: const Duration(seconds: 3),
              tween: Tween(begin: 0.0, end: 100.0),
              builder: (context, mark, _) => SizedBox(
                width: screenHeight * .04,
                height: screenHeight * .04,
                child: Stack(fit: StackFit.expand, children: [
                  CircularProgressIndicator(
                    value: mark,
                    strokeWidth: 5,
                    valueColor: const AlwaysStoppedAnimation(
                        Color.fromRGBO(30, 117, 229, 1)),
                  ),
                  Center(
                    child: buildProgress(mark),
                  )
                ]),
              ),
            );
          }
        });
  }
}
