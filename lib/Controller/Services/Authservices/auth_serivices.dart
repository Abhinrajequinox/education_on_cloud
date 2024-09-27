// import 'dart:developer';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AuthServices {
  // Method to send OTP to the provided email address
  Future<String> sendEmailOtp(String email) async {
    // Generate a random OTP
    String otp = generateOtp();

    // Define the SMTP server (using Gmail as an example)
    String username = 'abhinraj8086@gmail.com'; // Your email
    String password = '8592943588abhin'; // Your password or App Password

    // Create the SMTP server
    final smtpServer = gmail(username, password);

    // Create the message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(email)
      ..subject = 'Education On Cloud'
      ..text = 'OTP for Sign In Education On Cloud is: $otp';

    try {
      // Send the email
      await send(message, smtpServer);
      
      print("OTP sent successfully to $email");
      return otp;
    } catch (e) {
      print("Failed to send OTP: $e");
      return otp;
    }
  }

  // Method to generate a random OTP
  String generateOtp({int length = 4}) {
    final random = Random();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  // Method to verify the OTP (implement your own logic)
  bool verifyOtp(String enteredOtp, String actualOtp) {
    return enteredOtp == actualOtp; // Simple comparison, implement better logic as needed
  }

  
}
