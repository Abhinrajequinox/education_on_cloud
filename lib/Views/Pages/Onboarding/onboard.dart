import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Pages/Onboarding/firstonboard.dart';
import 'package:education_on_cloud/Views/Pages/Onboarding/secondonboard.dart';
import 'package:education_on_cloud/Views/Pages/Onboarding/thirdonboard.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Flexible(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    isLastPage = value == 2;
                  });
                },
                children:   [
                  OnboardFirstScreen(pageController: controller,),
                  OnboardSecondScreen(pageController: controller),
                 const OnboardThirdScreen(),
                ],
              ),
            ),
          
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: primarycolour,
                    ),
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: const Duration(seconds: 1), curve: Curves.linear),
                  ),
                ), Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLastPage
                      ? GestureDetector(
               child: Container(height: 42,width: 200,decoration:const BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo,Colors.blue]),borderRadius: BorderRadius.all(Radius.circular(50))),
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [CustomText(text: 'Get Started',textStyle: GoogleFonts.mulish(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w800),),
                     const Icon(Icons.arrow_circle_right,color: Colors.white,),
                   ],
                 ),
               ),),

                          onTap: () {
                            // Uncomment and navigate to Sign up screen
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const SignupScreen(),
                            //     ),
                            //     (route) => false);
                          },
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(height: 50,width: 50,decoration:const BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo,Colors.blue]),borderRadius: BorderRadius.all(Radius.circular(50))),child:const Icon(Icons.arrow_forward_sharp,color: Colors.white,),),
                        ),
                ],
              ),
            ),
              ],
            ),
            // Next or Sign Up button at the bottom
           
          ],
        ),
      ),
    );
  }
}
