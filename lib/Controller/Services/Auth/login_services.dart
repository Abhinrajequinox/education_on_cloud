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