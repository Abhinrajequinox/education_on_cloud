import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    // Define other light theme properties here
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    hintColor: Colors.redAccent,
    // Define other dark theme properties here
  );

  static final ThemeData summerTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.yellow,
    hintColor: Colors.orange,
    // Define other summer theme properties here
  );

  static final ThemeData winterTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    hintColor: Colors.white,
    // Define other winter theme properties here
  );

  static final ThemeData autumnTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    hintColor: Colors.brown,
    // Define other autumn theme properties here
  );

  static final ThemeData rainyTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    hintColor: Colors.grey,
    // Define other rainy theme properties here
  );
}
