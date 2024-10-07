// import 'dart:developer';

// import 'package:education_on_cloud/Controller/Services/Auth/auth_serivices.dart';
// import 'package:education_on_cloud/Views/Screens/Authentication/otp_screen.dart';
// import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
// import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
// import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginScreenWidget {
//   final AuthServices authServices = AuthServices();
//   // final AuthServices authServices=AuthServices();

//   Widget logoImage(double screenHeight, screenWidth) {
//     return Padding(
//         padding: EdgeInsets.only(
//             top: screenHeight * 0.1, bottom: screenHeight * 0.05),
//         child: SizedBox(
//             height: screenHeight * 0.1,
//             width: screenWidth * 0.5,
//             child: Image.asset('lib/Assets/titlelogo.png')));
//   }

//   Widget customLoginButton(
//       {required double screenWidth,
//       required GlobalKey<FormState> formKey,
//       required BuildContext context,
//       required String name,
//         required TextEditingController phoneController}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         CustomAuthButton(
//             width: screenWidth * 0.3,
//             text: 'Sign In',
//             onTap: () async{
//               log("the that enterd is $name");
//               log('the phone number that enterd is ${phoneController.text}');
              
//               if (formKey.currentState!.validate()) {
//               bool success=await  authServices.loginOtp(mobile: phoneController.text, name: name);
//               if (success) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => OtpScreen(
//                             logOrSingin: 'LogIn',
//                             phoneNumber: phoneController.text,
//                             userMail: name,
//                             userCountry: 'India')));
//               }else{
//                  customeSnakBar(
//                       'Login Failed. Please try again.', "", Icons.error);
//               }
              
//               }
//             })
//       ],
//     );
//   }

//   Widget newUserAccount(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CustomText(
//             text: 'If Your a New user?',
//             textStyle:
//                 GoogleFonts.mulish(fontSize: 14, fontWeight: FontWeight.w700)),
//         const SizedBox(width: 5),
//         GestureDetector(
//           onTap: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SignUpScreen(),
//               ),
//               (route) => false,
//             );
//           },
//           child: CustomText(
//               text: 'LOG IN',
//               textStyle: GoogleFonts.mulish(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w800,
//                   color: const Color.fromRGBO(9, 97, 245, 1))),
//         )
//       ],
//     );
//   }
// }
