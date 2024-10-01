import 'package:flutter/material.dart';

class AppThemes {
   static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Colors.blue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,  // Light app bar with primary color
      iconTheme: IconThemeData(color: Colors.white),  // White icons for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black87,
    colorScheme: const ColorScheme.dark(primary: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,  // Dark app bar
      iconTheme: IconThemeData(color: Colors.white),  // White icons for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData summerTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor:const Color.fromRGBO(26, 26, 26, 1),  // Soft light yellow
    colorScheme: const ColorScheme.light(primary: Color.fromRGBO(26, 26, 26, 1)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,  // Summer theme app bar
      iconTheme: IconThemeData(color: Colors.white),  // Black icons for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData winterTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.blueGrey[50]!,  // Light blue-grey background
    colorScheme: const ColorScheme.light(primary: Colors.blueGrey),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueGrey,  // Winter theme app bar
      iconTheme: IconThemeData(color: Colors.black),  // Black icons for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData autumnTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor:const Color.fromRGBO(245, 222, 179, 1),  // Soft light orange
    colorScheme: const ColorScheme.light(primary: Colors.orange),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(245, 222, 179, 1),  // Autumn theme app bar
      iconTheme: IconThemeData(color: Colors.black),  // Black icons for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData rainyTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.lightBlueAccent,  
    scaffoldBackgroundColor: Colors.lightBlue[50],  
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 173, 216, 230),  
      secondary: Color.fromARGB(255, 135, 206, 250), 
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 173, 216, 230), 
      iconTheme: IconThemeData(color: Colors.black), 
    ),
    textTheme:const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), 
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
