import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardThirdScreen extends StatelessWidget {
  const OnboardThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
               
              const SizedBox(height: 210),
              SizedBox(height: 300,child: Image.asset('lib/Views/Pages/Onboarding/onboardthird.png')),
               const SizedBox(height: 55),
             Stack(children:[const SizedBox(height: 40,child: CustomText(text: 'Get Online Certificate',fontWeight: FontWeight.w600,fontSize: 18,)),
             Positioned(top:  25,left: 105,child: SizedBox(width: 75,child: Image.asset('lib/Assets/Onboard/image.png'))),]),
             const SizedBox( height: 10),
             const CustomText(text: 'Get your certificate in technical, non-technical, and vocational fields.',fontWeight: FontWeight.w700,color: Color.fromRGBO(84, 84, 84, 1),textalign: TextAlign.center,)
             
            ],
          ),
      ),
    );
  }
}