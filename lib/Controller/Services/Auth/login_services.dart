import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {

  // Function to save login status
Future<void> saveLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}


Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn'); // or prefs.clear() to clear all stored preferences
}

Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }


  Future<void> checkLoginStatus(BuildContext context) async {
    bool isLoggedIn = await getLoginStatus();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>const  HomeBottomNavigationBar()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>const SignUpScreen()),
      );
    }
  }
  
}


class UserPreferences {
  static const String _usernameKey = 'username';
  static const String _phoneNumberKey = 'phoneNumber';
  static const String _countryKey = 'country';
  static const String _stateKey = 'state';
  static const String _emailKey = 'email';

  // Store user details
  static Future<void> saveUserDetails({
    required String username,
    required String phoneNumber,
    required String country,
    required String state,
    required String email,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_phoneNumberKey, phoneNumber);
    await prefs.setString(_countryKey, country);
    await prefs.setString(_stateKey, state);
    await prefs.setString(_emailKey, email);
  }

  // Retrieve user details
  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey),
      'phoneNumber': prefs.getString(_phoneNumberKey),
      'country': prefs.getString(_countryKey),
      'state': prefs.getString(_stateKey),
      'email': prefs.getString(_emailKey),
    };
  }

  // Delete user details
  static Future<void> deleteUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_phoneNumberKey);
    await prefs.remove(_countryKey);
    await prefs.remove(_stateKey);
    await prefs.remove(_emailKey);
  }
}
