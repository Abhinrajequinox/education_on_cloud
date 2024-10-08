// import 'dart:developer';
import 'dart:convert';
import 'dart:developer';
import 'package:education_on_cloud/Apis/apis.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<bool> submitRequest({
    required String name,
    required String number,
    required String country,
    required String state,
    required String email,
  }) async {
    log('the phone number in the sumbmit request is $number');
    log('the phone number in the sumbmit request is $email');

    try {
      final response = await http.post(
        Uri.parse(signinPostApi),
        body: {
          'user_name': name,
          'country': country == 'India' ? '0' : '1',
          'mobile_num': number,
          'state': state,
          'emai': email,
          'username': name
        },
      );

      // Log the raw response for debugging
      log('Response body: ${response.body}');

      // Extract the JSON part of the response
      String jsonResponseString =
          response.body.substring(response.body.indexOf('{'));

      // Attempt to decode the extracted JSON
      var jsonResponse = json.decode(jsonResponseString);

      switch (response.statusCode) {
        case 200:
          log('Sign-in successful: $jsonResponse');
          return true; // Indicate success
        case 400:
          log('Bad request: $jsonResponse');
          return false; // Indicate failure
        case 401:
          log('Unauthorized: $jsonResponse');
          return false; // Indicate failure
        case 403:
          log('Forbidden: $jsonResponse');
          return false; // Indicate failure
        case 404:
          log('Not found: $jsonResponse');
          return false; // Indicate failure
        case 500:
          log('Server error: $jsonResponse');
          return false; // Indicate failure
        default:
          log('Unexpected error: ${response.statusCode} $jsonResponse');
          return false; // Indicate failure
      }
    } catch (e) {
      log('Error: $e');
      return false; // Indicate failure on exception
    }
  }

  Future<bool> checkGetOtp(
      {required String mobile, required String otp}) async {
    try {
      log('the mobile number for verfing otp Is $mobile');
      log('the otp Is get is $otp');
      final response = await http
          .post(Uri.parse(otpGetApi), body: {'mobile_num': mobile, 'otp': otp});

      // Log the raw response for debugging
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          // Successful response
          log('OTP retrieval successful');
          if (response.body == '1') {
            log('OTP verification successful');
            return true;
          } else if (response.body == '2') {
            log('OTP verification failed');
            return false;
          } else {
            log('Unexpected response body: ${response.body}');
            return false; // Handle any other response as failure
          } // Return the body as a string

        case 400:
          log('Bad request: ${response.body}');
          return false; // Indicate failure

        case 401:
          log('Unauthorized: ${response.body}');
          return false; // Indicate failure

        case 403:
          log('Forbidden: ${response.body}');
          return false; // Indicate failure

        case 404:
          log('Not found: ${response.body}');
          return false; // Indicate failure

        case 500:
          log('Server error: ${response.body}');
          return false; // Indicate failure

        default:
          log('Unexpected error: ${response.statusCode} ${response.body}');
          return false; // Indicate failure
      }
    } catch (e) {
      log('Error occurred while checking OTP: $e');
      return false; // Indicate failure on exception
    }
  }

  Future<bool> storeSignInDetails(
      {required String name,
      required String mobile,
      required String state,
      required String email,
      required String country}) async {
    try {
      log('the mobile number for verfing otp Is $mobile');
      log('the otp Is get is $state');
      final response =
          await http.post(Uri.parse(store_sigin_details_Api), body: {
        'username': name,
        'mob': mobile,
        'state': state,
        'email': email,
        'country': country,
        'mode': 'thelearnyn'
      });

      // Log the raw response for debugging
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          // Successful response
          log('reginster successful');
          if (response.body == '1') {
            log('reginster successful');
            return true;
          } else if (response.body == '2') {
            log('reginster failed');
            return false;
          } else {
            log('Unexpected response body: ${response.body}');
            return false; // Handle any other response as failure
          } // Return the body as a string

        case 400:
          log('Bad request: ${response.body}');
          return false; // Indicate failure

        case 401:
          log('Unauthorized: ${response.body}');
          return false; // Indicate failure

        case 403:
          log('Forbidden: ${response.body}');
          return false; // Indicate failure

        case 404:
          log('Not found: ${response.body}');
          return false; // Indicate failure

        case 500:
          log('Server error: ${response.body}');
          return false; // Indicate failure

        default:
          log('Unexpected error: ${response.statusCode} ${response.body}');
          return false; // Indicate failure
      }
    } catch (e) {
      log('Error occurred while checking OTP: $e');
      return false; // Indicate failure on exception
    }
  }
  Future<bool> fetchSignInDetails(
      {required String name,
      required String mobile,
      required String state,
      required String email,
      required String country}) async {
    try {
      log('the mobile number for verfing otp Is $mobile');
      log('the otp Is get is $state');
      final response =
          await http.post(Uri.parse(store_sigin_details_Api), body: {
        'username': name,
        'mob': mobile,
        'state': state,
        'email': email,
        'country': country,
        'mode': 'thelearnyn'
      });

      // Log the raw response for debugging
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          // Successful response
          log('reginster successful');
          if (response.body == '1') {
            log('reginster successful');
            return true;
          } else if (response.body == '2') {
            log('reginster failed');
            return false;
          } else {
            log('Unexpected response body: ${response.body}');
            return false; // Handle any other response as failure
          } // Return the body as a string

        case 400:
          log('Bad request: ${response.body}');
          return false; // Indicate failure

        case 401:
          log('Unauthorized: ${response.body}');
          return false; // Indicate failure

        case 403:
          log('Forbidden: ${response.body}');
          return false; // Indicate failure

        case 404:
          log('Not found: ${response.body}');
          return false; // Indicate failure

        case 500:
          log('Server error: ${response.body}');
          return false; // Indicate failure

        default:
          log('Unexpected error: ${response.statusCode} ${response.body}');
          return false; // Indicate failure
      }
    } catch (e) {
      log('Error occurred while checking OTP: $e');
      return false; // Indicate failure on exception
    }
  }

  Future<bool> oneTimeloginOtp(
      {required String mobile, required String otp}) async {
    try {
      final response = await http.post(Uri.parse(otp_login_one_device_Api),
          body: {'mob': mobile, 'otp': otp});

      // Log the raw response for debugging
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          // Successful response
          log('OTP retrieval successful');
          return true; // Return the body as a string

        case 400:
          log('Bad request: ${response.body}');
          return false; // Indicate failure

        case 401:
          log('Unauthorized: ${response.body}');
          return false; // Indicate failure

        case 403:
          log('Forbidden: ${response.body}');
          return false; // Indicate failure

        case 404:
          log('Not found: ${response.body}');
          return false; // Indicate failure

        case 500:
          log('Server error: ${response.body}');
          return false; // Indicate failure

        default:
          log('Unexpected error: ${response.statusCode} ${response.body}');
          return false; // Indicate failure
      }
    } catch (e) {
      log('Error occurred while checking OTP: $e');
      return false; // Indicate failure on exception
    }
  }

  // Future<bool> loginOtp(
  //     {required String mobile, required String name}) async {
  //   try {
  //     final response = await http.post(Uri.parse(loginGenerateOtp),
  //         body: {'mobile_num': mobile});

  //     // Log the raw response for debugging
  //     log('Response status code: ${response.statusCode}');
  //     log('Response body: ${response.body}');

  //     switch (response.statusCode) {
  //       case 200:
  //         // Successful response
  //         log('OTP retrieval successful for login');
  //         return true; // Return the body as a string

  //       case 400:
  //         log('Bad request: ${response.body}');
  //         return false; // Indicate failure

  //       case 401:
  //         log('Unauthorized: ${response.body}');
  //         return false; // Indicate failure

  //       case 403:
  //         log('Forbidden: ${response.body}');
  //         return false; // Indicate failure

  //       case 404:
  //         log('Not found: ${response.body}');
  //         return false; // Indicate failure

  //       case 500:
  //         log('Server error: ${response.body}');
  //         return false; // Indicate failure

  //       default:
  //         log('Unexpected error: ${response.statusCode} ${response.body}');
  //         return false; // Indicate failure
  //     }
  //   } catch (e) {
  //     log('Error occurred while checking OTP: $e');
  //     return false; // Indicate failure on exception
  //   }
  // }
}
