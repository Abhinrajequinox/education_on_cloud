import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardSecondScreen extends StatelessWidget {
  final PageController pageController;
  
  const OnboardSecondScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // 2% of screen width
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1, // 10% of screen height
                    right: screenWidth * 0.05, // 5% of screen width
                  ),
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CustomText(
                      text: 'Skip',
                      textStyle: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.04, // 4% of screen width
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02, // 2% of screen height
            ),
            SizedBox(
              height: screenHeight * 0.47,  
              child: Image.asset('lib/Assets/Onboard/onboardsecond.png'),
            ),
            SizedBox(
              height: screenHeight * 0.02,  
            ),
            Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.05, 
                  child: CustomText(
                    text: 'Take Class Where you need',
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.05, 
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.03, 
                  left: screenWidth * 0.38, 
                  child: SizedBox(
                    width: screenWidth * 0.15,  
                    child: Image.asset('lib/Assets/Onboard/image.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,  
            ),
            CustomText(
              text: 'Analyse your scores and Track your results',
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(84, 84, 84, 1),
              fontSize: screenWidth * 0.04,  
              textalign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
