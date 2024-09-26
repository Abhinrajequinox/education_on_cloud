import 'dart:developer';

import 'package:email_auth/email_auth.dart';

class AuthServices {
  final EmailAuth emailAuth;

  AuthServices() : emailAuth = EmailAuth(sessionName: "mail otp");

  Future<void> sendEmailOtp(String email) async {
    emailAuth.config({
      "sender": "abhinraj8086@gmail.com"
    });

    // Send OTP
    var response = await emailAuth.sendOtp(recipientMail: email, otpLength: 4);

    if (response) {
      log("OTP sent successfully");
    } else {
      log("Failed to send OTP");
    }
  }

  // Method to verify the OTP
  bool verifyOtp(String email, String otp) {
    var response = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
    return response; // Returns true if the OTP is valid, false otherwise
  }
}
