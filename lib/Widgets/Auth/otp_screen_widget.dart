import 'dart:developer';
import 'package:education_on_cloud/Controller/AuthController/otp_screen_controller.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_bottom_navigation_bar.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreenWidget {
  final OtpScreenController otpScreenController=OtpScreenController();

  Widget logoImage() {
    return Padding(
        padding: const EdgeInsets.only(top: 117, bottom: 50),
        child: SizedBox(
            height: 90,
            width: 184.29,
            child: Image.asset('lib/Assets/titlelogo.png')));
  }

  Widget otpDetails(String userCountry, userNumber, userMail) {
    return userCountry == 'India'
        ? CustomText(
            text: 'Enter the code from the sms we sent to $userNumber',
            textStyle:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
            textalign: TextAlign.center)
        : CustomText(
            text: 'Enter the code we sent to your mail $userMail',
            textStyle:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
            textalign: TextAlign.center);
  }

  Widget piputBox() {
    return Obx(
      ()=> Pinput(
          length: 4, // OTP length is 4
          onChanged: (value) {
            otpScreenController.changeOtpCheck(false);
            otpScreenController.changingEnterdVal(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 4) {
              return '';
            }
            return null;
          },
          defaultPinTheme: PinTheme(
              width: 66,
              height: 53,
              textStyle: TextStyle(
                  fontSize: 24,
                  color: otpScreenController.otpCheck.value==false
                      ? Colors.black
                      : Colors.red),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              margin: const EdgeInsets.symmetric(horizontal: 10)),
          focusedPinTheme: PinTheme(
              width: 60,
              height: 56,
              textStyle: const TextStyle(fontSize: 24, color: Colors.blue),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue))),
          cursor: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                width: 30,
                height: 1,
                color: Colors.blue,
                margin: const EdgeInsets.only(bottom: 8))
          ]),
          pinAnimationType: PinAnimationType.fade),
    );
  }

  Widget resendMail() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CustomText(
          text: '''I didn't receive any code.''',
          textStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14)),
      GestureDetector(
          onTap: () {},
          child: CustomText(
              text: ' RESEND',
              textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color.fromRGBO(0, 56, 255, 1))))
    ]);
  }

  Widget submitButton(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomAuthButton(
          text: 'SUBMIT',
          width: 142,
          onTap: () {
            if (otpScreenController.enterdVal.value == '8592') {
              otpScreenController.changeOtpCheck(false);
              log('enterd otp is correct');
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const HomeBottomNavigationBar(),), (route) => false,);
            } else {
              otpScreenController.changeOtpCheck(true);
            }
          })
    ]);
  }

  Widget wrongOtpMessage() {
    return Obx(() => Visibility(
        visible: otpScreenController.otpCheck.value,
        child: SizedBox(
            height: 40,
            child: CustomText(
                text: 'Wrong OTP',
                textStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.red)))));
  }
}
