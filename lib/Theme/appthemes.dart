import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,          // Primary color
      secondary: Colors.green,       // Secondary color
    ),
    // Define other light theme properties here
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    hintColor: Colors.redAccent,
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,        
      secondary: Colors.redAccent,   
    ),
  );

  static final ThemeData summerTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.yellow,
    hintColor: Colors.orange,
    colorScheme: const ColorScheme.light(
      primary: Colors.yellow,        
      secondary: Colors.orangeAccent,  
    ),
    
  );

  static final ThemeData winterTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    hintColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.blueGrey,       
      secondary: Colors.cyanAccent,  
    ),
    
  );

  static final ThemeData autumnTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    hintColor: Colors.brown,
    colorScheme: const ColorScheme.light(
      primary: Colors.orange,        
      secondary: Colors.deepOrangeAccent,  
    ),
     
  );

  static final ThemeData rainyTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    hintColor: Colors.grey,
    colorScheme: const ColorScheme.light(
      primary: Colors.blueAccent,     
      secondary: Colors.lightBlue,  
    ),
    
  );
}
