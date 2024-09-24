import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardSecondScreen extends StatelessWidget {
  final PageController pageController;
  const OnboardSecondScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                                Padding(
                      padding:const EdgeInsets.only(top: 90,right: 20),
                      child: TextButton(onPressed: () {
                        pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      }, child:  CustomText(text: 'Skip', textStyle: GoogleFonts.mulish(fontWeight: FontWeight.w600,fontSize: 16),)),
                    )
                  ],
                ), const SizedBox(
                height: 10,
              ),
              SizedBox(height: 400,child: Image.asset('lib/Assets/Onboard/onboardsecond.png')),
               const SizedBox(
                height:20,
              ),
             Stack(children:[const SizedBox(height: 40,child: CustomText(text: 'Take Class Where you need',fontWeight: FontWeight.w600,fontSize: 18,)),
             Positioned(top:  25,left: 150,child: SizedBox(width: 75,child: Image.asset('lib/Assets/Onboard/image.png'))),]),
             const SizedBox( height:5),
             const CustomText(text: 'Analyse your scores and Track your results',fontWeight: FontWeight.w700,color: Color.fromRGBO(84, 84, 84, 1),textalign: TextAlign.center,)
             
            ],
          ),
      ),
    );
  }
}