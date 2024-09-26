import 'dart:developer';

import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

final TextEditingController _firstOpt = TextEditingController();
final TextEditingController _secOpt = TextEditingController();
final TextEditingController _thirdtOpt = TextEditingController();
final TextEditingController _fourOpt = TextEditingController();
final _formKey=GlobalKey<FormState>();

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(widget.phoneNumber, context),
    );
  }
}

Widget _body(String userNumber, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 117, bottom: 50),
            child: SizedBox(
              height: 90,
              width: 184.29,
              child: Image.asset('lib/Assets/titlelogo.png'),
            ),
          ),
          CustomText(
              text: 'Enter the code from the sms we sent to $userNumber',
              textStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textalign: TextAlign.center),
          const SizedBox(height: 30),
          Form(key: _formKey,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOtpBlock(
                otpController: _firstOpt,
              ),
              CustomOtpBlock(
                otpController: _secOpt,
              ),
              CustomOtpBlock(
                otpController: _thirdtOpt,
              ),
              CustomOtpBlock(
                otpController: _fourOpt,
              ),
            ],
          )),
          const SizedBox(height: 30),
          Visibility(visible: true,
              child: SizedBox(
                  height: 40,
                  child: CustomText(
                    text: 'Wrong OTP',
                    textStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: '''I didn't receive any code.''',
                textStyle:
                    GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              CustomText(
                text: ' RESEND',
                textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color.fromRGBO(0, 56, 255, 1)),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAuthButton(
                text: 'SUBMIT',
                width: 142,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    log('okeyy');
                  }else{
                    
                  }
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}
