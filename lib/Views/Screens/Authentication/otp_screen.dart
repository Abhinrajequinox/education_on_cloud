
import 'package:education_on_cloud/Widgets/Auth/otp_screen_widget.dart';
import 'package:flutter/material.dart';


class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String userMail;
  final String userCountry;
  final String otp;
  const OtpScreen(
      {super.key,
      required this.phoneNumber,
      required this.userMail,
      required this.userCountry,
      required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

OtpScreenWidget otpScreenWidget = OtpScreenWidget();
String enteredOtp = '';

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _body(
            widget.phoneNumber, widget.userMail, widget.userCountry, context));
  }
}

Widget _body(String userNumber, userMail, userCountry, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
          child: Column(children: [
            // logo image session
        otpScreenWidget.logoImage(),
        // mail or phone otp text session
        otpScreenWidget.otpDetails(userCountry, userNumber, userMail),
        const SizedBox(height: 30),
        // otp enter session
        otpScreenWidget.piputBox(),
        const SizedBox(height: 30),
        // wrong otp enter session
        otpScreenWidget.wrongOtpMessage(),
        // resend otp text session
        otpScreenWidget.resendMail(),
        const SizedBox(height: 30),
        // submit button session
        otpScreenWidget.submitButton(context)
      ])));
}
