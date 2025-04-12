import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF181818), 
    primary: Color(0xFFFFA825), 
    secondary: Color(0xFF222222), 
    tertiary: Color(0xFF303030), 
    inversePrimary: Colors.grey.shade300,
    onBackground: const Color.fromARGB(255, 54, 51, 51) 
  ),
);
