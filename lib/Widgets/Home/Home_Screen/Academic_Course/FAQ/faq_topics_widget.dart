import 'dart:developer';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/chapter_topic_controller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/faq_topi_screen_controller.dart';
import 'package:education_on_cloud/Controller/Home_Screen_Controller/Academic_course/theory_chapter_screen_controller.dart';
import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/chapters_model.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/faq_model.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Chapters/chapters_topic_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/FAQ/faq_chapters_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/course_category_screen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Views/Screens/Home/Acadamic_Course/Theory/theory_classes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqTopicScreenWidget {
  // List<AcademicTheoryClassModel> theoryClass = [];
  // final TheoryChapterScreenController theorychapterScreenController =
  //     TheoryChapterScreenController();
  final FaqTopiScreenController faqTopiScreenController =
      FaqTopiScreenController();
  // final AcademicCourseServices academicCourseServices =
  //     AcademicCourseServices();
  // final AcademicChapterTopicController academicChapterTopicController =
  //     AcademicChapterTopicController();
  Widget titleAndBackButton(BuildContext context, double screenWidth,
      String titleOfChapter, String titleName) {
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
                    text: '$titleName - FAQ’s',
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

  Widget typesOfNotes(
      {required double screenHeight, required double screenWidth}) {
    return Container(
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                faqTopiScreenController.changeNoteType('long');
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.038,
                    width: screenWidth * 0.28,
                    child: faqTopiScreenController.noteType.value == 'long'
                        ? Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button-choose.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * .008,
                      child: CustomText(
                        text: 'Long Notes',
                        textStyle: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 10),
                      ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                faqTopiScreenController.changeNoteType('short');
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.038,
                    width: screenWidth * 0.28,
                    child: faqTopiScreenController.noteType.value == 'short'
                        ? Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button-choose.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * .008,
                      child: CustomText(
                        text: 'Short Notes',
                        textStyle: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 10),
                      ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                faqTopiScreenController.changeNoteType('quick');
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.038,
                    width: screenWidth * 0.28,
                    child: faqTopiScreenController.noteType.value == 'quick'
                        ? Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button-choose.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'lib/Assets/Home/Buttons/E-note-button.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * .008,
                      child: CustomText(
                        text: 'Quick Notes',
                        textStyle: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 10),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageChangeDropDownContainer({
    required double screenHeight,
    required double screenWidth,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          // Toggle the dropdown expansion and arrow animation
          faqTopiScreenController.toggleDropdown();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          height: screenHeight * 0.04,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.g_translate),
              CustomText(
                text: 'Select your language here',
                color: Colors.black,
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16), // Adjust space if needed
              AnimatedRotation(
                turns: faqTopiScreenController.iconRotation.value,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget languageOptionsList({
    required double screenHeight,
    required double screenWidth,
  }) {
    return Obx(() {
      return faqTopiScreenController.isDropdownExpanded.value
          ? FutureBuilder<String>(
              future: languageController.getCurrentLanguageCode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while the language code is being fetched
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle the error state if there is any issue fetching the language
                  return const Center(child: Text('Error loading language'));
                } else if (snapshot.hasData) {
                  var lang = snapshot.data!; // Get the language code
                  return Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    height: screenHeight *
                        0.55, // Set a fixed height for the dropdown list
                    child: ListView.builder(
                      itemCount: indianLanguages.length,
                      itemBuilder: (context, index) {
                        final language = indianLanguages[index];
                        final isSelected = lang == language["code"];
                        log(lang.toString());

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (contextshow) {
                                return customAlertBox(
                                    cancelContext: context,
                                    confirm: () {
                                      Navigator.pop(context);
                                      // Call selectLanguage with language code and country
                                      faqTopiScreenController.selectLanguage(
                                        language[
                                            "code"]!, // Pass the correct language code
                                        language[
                                            "country"]!, // Pass the country code
                                      );
                                      faqTopiScreenController
                                          .toggleExpansion(-1);
                                    },
                                    content:
                                        'Are you sure Do you want to change the Language into ${language["language"]!} ?',
                                    confirmText: 'Yes',
                                    cancelText: 'No',
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth);
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01),
                            child: Container(
                              height:
                                  screenHeight * 0.038, // 4.5% of screen height
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isSelected
                                    ? const Color.fromRGBO(239, 246, 255, 1)
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenHeight * 0.02),
                                    child: Container(
                                      width: screenHeight * 0.025,
                                      height: screenHeight * 0.025,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            screenHeight * 0.005), // 0.5%
                                        child: CircleAvatar(
                                          radius: screenHeight *
                                              0.0125, // 1.25% of screen height
                                          backgroundColor: isSelected
                                              ? const Color.fromARGB(
                                                  255, 9, 97, 245)
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    language["language"]!,
                                    style: GoogleFonts.lato(
                                      fontSize: screenHeight *
                                          0.02, // 2% of screen height
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // If no data, return an empty widget or a fallback UI
                  return const SizedBox.shrink();
                }
              },
            )
          : const SizedBox.shrink(); // Collapsed dropdown
    });
  }

  Widget listOfChapters(
      {required List<ChapterSubTopicModel> chapters,
      required double screenHeight,
      required double screenWidth,
      required String languageName,
      required String titleOfChapter,
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
                  faqTopiScreenController.toggleExpansion(index);
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
                                'lib/Assets/Home/Drawer_icon/chapters-img-icon.png'),
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
                                    text: '${index + 1} . ${chapter.subTopic}',
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
                                text: 'Get FAQ’s',
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
                              turns: faqTopiScreenController
                                      .getRotationState(index)
                                  ? 0
                                  : 0.5, // Rotate 180 degrees when expanded
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: GestureDetector(
                                onTap: () async {
                                  faqTopiScreenController
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
              if (faqTopiScreenController.isExpanded(index)) {
                log(chapter.id);
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  // height: screenHeight * 0.33,
                  width: screenWidth * 0.9, // Adjust based on content
                  child: Card(
                    elevation: 3,
                    child: FutureBuilder<List<AcademicFaqEnoteModel>>(
                      future: academicFaqServices.fetchFaqs(
                        id: chapter.id,
                        noteType: faqTopiScreenController.noteType.value,
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<AcademicFaqEnoteModel>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No Notes available'));
                        } else {
                          List<AcademicFaqEnoteModel> chapters = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: chapters.length,
                            itemBuilder: (context, chapterIndex) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable scrolling for nested ListView
                                itemCount:
                                    chapters[chapterIndex].sections.length,
                                itemBuilder: (context, sectionIndex) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenHeight * 0.01,
                                        vertical: screenHeight * 0.005),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.15,
                                              child: Image.asset(
                                                  'lib/Assets/titlelogo.png'),
                                            )
                                          ],
                                        ),
                                        FutureBuilder<String>(
                                          future: languageController
                                              .translateApiText(
                                                  chapters[chapterIndex]
                                                      .sections[sectionIndex]),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text(
                                                  'Loading...'); // Placeholder while translating
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}'); // Error handling
                                            } else {
                                              // Successfully translated
                                              return eNoteTexts(snapshot.data ??
                                                  chapters[chapterIndex]
                                                      .sections[sectionIndex]);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
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

  Widget eNoteTexts(String text) {
    // Split the text into parts for processing
    List<TextSpan> textSpans = _processText(text);

    return RichText(
      text: TextSpan(
        style: GoogleFonts.kalam(color: Colors.black), // Default text color
        children: textSpans,
      ),
    );
  }

  List<TextSpan> _processText(String text) {
    // Split the text by new lines (double line breaks for paragraphs)
    List<String> lines = text.split('\n\n');
    List<TextSpan> spans = [];

    for (String line in lines) {
      // Check for heading with #
      if (line.startsWith('#')) {
        // Detect and style heading based on # count
        if (line.startsWith('##')) {
          // Sub-heading (##)
          String subheadingText = line.replaceAll(RegExp(r'^##\s*'), '');
          spans.add(TextSpan(
            text: subheadingText,
            style: GoogleFonts.kalam(
              color: Colors.black,
              fontWeight: FontWeight.w600, // Sub-heading style
              fontSize: 16, // Adjust the font size for sub-heading
            ),
          ));
        } else {
          // Main heading (#)
          String headingText = line.replaceAll(RegExp(r'^#\s*'), '');
          spans.add(TextSpan(
            text: headingText,
            style: GoogleFonts.kalam(
              color: Colors.black,
              fontWeight: FontWeight.w700, // Main heading style
              fontSize: 18, // Adjust the font size for heading
            ),
          ));
        }
        spans
            .add(const TextSpan(text: '\n\n')); // Add spacing after the heading
      } else {
        // For regular text, process **bold** by replacing it and applying styles
        String processedLine = line;
        RegExp boldRegex =
            RegExp(r'\*\*(.*?)\*\*'); // Regex to detect **bold** text

        // Split the line by the ** markers to identify and style bold text
        List<String> parts = processedLine.split(boldRegex);
        for (int i = 0; i < parts.length; i++) {
          String part = parts[i];

          if (i % 2 == 1) {
            // This is the bold part
            spans.add(TextSpan(
              text: part,
              style: GoogleFonts.kalam(
                color: Colors.black,
                fontWeight: FontWeight.w700, // Bold text style
                fontSize: 14, // Font size for bold text
              ),
            ));
          } else {
            // This is the regular part
            spans.add(TextSpan(
              text: part,
              style: GoogleFonts.kalam(
                color: Colors.black, // Regular text style
                fontSize: 14, // Font size for regular text
              ),
            ));
          }
        }
        spans.add(
            const TextSpan(text: '\n\n')); // Add spacing after the regular text
      }
    }

    return spans;
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
