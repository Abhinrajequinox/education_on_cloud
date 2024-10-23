import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/quick_tips_video_controller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/theory_video_controller.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/Revision_classes_model.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart'; // Import GetX package


class AcdemicQucikTipsVideoClasssWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Create an instance of the GetX Controller
  final AcademicQuickTipsVideoController academicQuickTipsVideoController=AcademicQuickTipsVideoController();

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

  Widget listOfClass({
    required List<AcademicTheoryChapterModelClass> classes,
    required double screenHeight,
    required double screenWidth,
    required String languageName,
    required String titleOfClass,
    required Color cardColor,
  }) {
    // Define currentClasses here
    List<AcademicTheoryChapterModelClass> currentClasses =
        List.from(classes); // Clone the original list

    return Column(
      children: [
        // Display the video player with reactive URL and name
        Obx(() {
          if (academicQuickTipsVideoController.currentVideoUrl.value.isNotEmpty) {
            return SizedBox(
              child: _buildWebViewVideoPlayer(
                videoUrl: academicQuickTipsVideoController.currentVideoUrl.value,
                videoName: academicQuickTipsVideoController.currentVideoName.value,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            );
          }
          return Container(); // Return an empty container if no video URL is set
        }),
        AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          initialItemCount: currentClasses.length,
          itemBuilder: (context, index, animation) {
            return _buildClassCard(
                context,
                index,
                currentClasses[index],
                animation,
                screenHeight,
                screenWidth,
                titleOfClass,
                cardColor,
                currentClasses);
          },
        ),
      ],
    );
  }

  Widget _buildClassCard(
      BuildContext context,
      int index,
      AcademicTheoryChapterModelClass theoryClass,
      Animation<double> animation,
      double screenHeight,
      double screenWidth,
      String titleOfClass,
      Color cardColor,
      List<AcademicTheoryChapterModelClass> currentClasses) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1), // Start below the screen
          end: Offset.zero, // End at original position
        ).animate(animation),
        child: GestureDetector(
          onTap: () {
            String videoUrl = theoryClass.vidUrl;
            if (videoUrl.isNotEmpty) {
              // Update the currently playing video URL and name in the controller
              academicQuickTipsVideoController.updateVideo(videoUrl,
                  '$titleOfClass :- QuickTips ${theoryClass.part}');
              academicQuickTipsVideoController.changeFavIcon(true);
              academicQuickTipsVideoController.changeTakeNote(false);
              if (index != 0) {
                // Only update if it's not already the first item
                _listKey.currentState?.removeItem(
                  index,
                  (context, animation) => _buildClassCard(
                      context,
                      index,
                      theoryClass,
                      animation,
                      screenHeight,
                      screenWidth,
                      titleOfClass,
                      cardColor,
                      currentClasses),
                  duration: const Duration(milliseconds: 300),
                );

                // Insert the item at the top
                currentClasses.insert(0, currentClasses.removeAt(index));
                _listKey.currentState?.insertItem(0,
                    duration: const Duration(milliseconds: 300));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Video URL not available')),
              );
            }
          },
          child: Card(
            elevation: 3,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: cardColor, width: 3),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                        'lib/Assets/Home/chapter-screen-background-image.png'),
                    fit: BoxFit.cover,
                    opacity: .4,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                height: screenHeight * .09,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        width: screenWidth * .2,
                        child: ClipRRect(borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          child: Image.network(
                              theoryClass.thumbnail),
                        ),
                      ),
                      SizedBox(width: screenWidth * .02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * .4,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          SizedBox(height: screenHeight * 0.015),
                          SizedBox(
                            width: screenWidth * .6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'QuickTips - ${theoryClass.part}',
                                  textStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color:
                                          const Color.fromRGBO(0, 56, 255, 1)),
                                ),
                                SizedBox(width: screenWidth * .07),
                                Container(
                                  width: screenWidth * .23,
                                  height: screenHeight * .025,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color.fromRGBO(30, 117, 229, 1)),
                                  child: Center(
                                    child: CustomText(
                                      text: 'Go to Class',
                                      textStyle: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Positioned(
                    top: -5,
                    left: 310,
                    child: academicQuickTipsVideoController.favIcon.value == true
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border))
                        : const SizedBox()),
              )
            ]),
          ),
        ),
      ),
    );
  }

  // Replace the WebViewVideoPlayer with this function
  Widget _buildWebViewVideoPlayer(
      {required String videoUrl,
      required String videoName,
      required double screenHeight,
      required double screenWidth}) {
    if (videoUrl.isEmpty) {
      return Container(); // Do not display WebView if there's no video URL
    }
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            log("Page started loading: $url"); // Debugging
          },
          onPageFinished: (String url) {
            log("Page finished loading: $url"); // Debugging
          },
          onHttpError: (HttpResponseError error) {
            log("HTTP error: "); // Debugging
          },
          onWebResourceError: (WebResourceError error) {
            log("Web resource error: ${error.errorCode}"); // Debugging
          },
          onNavigationRequest: (NavigationRequest request) {
            log("Navigation request: ${request.url}"); // Debugging
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://educationoncloud.in/new/ajax/get_vid.php?vid=$videoUrl&viewonly'));
    return Padding(
      padding: EdgeInsets.all(screenWidth * .02),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth * 04,
                // height: screenHeight * .42,
                decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.grey.shade400),
                    // color: Colors.yellow,
                    borderRadius: const BorderRadius.all( Radius.circular(6))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      top: screenHeight * .4,
                      bottom: screenHeight * .02),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        academicQuickTipsVideoController.takeNote.value == false
                            ? GestureDetector(
                                onTap: () {
                                  academicQuickTipsVideoController.changeTakeNote(true);
                                },
                                child: Row(
                                  children: [
                                    const ImageIcon(AssetImage(
                                        'lib/Assets/Icons/note-icon.png')),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    CustomText(
                                      text: 'Click here to take notes.',
                                      textStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Take Your Notes Here',
                                    textStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            0, 56, 255, 1)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.01,
                                          right: screenWidth * 0.01),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: 'Clear Notes ',
                                            textStyle: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          const ImageIcon(AssetImage(
                                              'lib/Assets/Icons/brush-icon.png'))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        academicQuickTipsVideoController.takeNote.value == true
                            ? TextFormField(
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none)),
                                maxLines: null,
                                style: GoogleFonts.kalam(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  // height: screenHeight * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: screenHeight * 0.307,
                          child: WebViewWidget(controller: controller,)),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'SSLC - Mathematics',
                              textStyle: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(0, 56, 255, 1)),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * .02),
                        child: SizedBox(
                          width: screenWidth * .8,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomText(
                                  text: videoName,
                                  textStyle: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
