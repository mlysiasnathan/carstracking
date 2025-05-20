import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4CAF50),
  // Golden Yellow
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4CAF50),
    secondary: Color(0xFF87CEEB),
    // Sky Blue
    tertiary: Color(0xFF2ECC71),
    // Fresh Green
    error: Colors.redAccent,
    surface: Color(0xFFF1F1F1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4CAF50),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFFFF8C00),
    contentTextStyle: const TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFFFF9E5),
    hintStyle: const TextStyle(color: Colors.black45),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.all(16),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Color(0xFFF1F1F1),
    selectedItemColor: Color(0xFF4CAF50),
    selectedLabelStyle: TextStyle(color: Colors.red),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    showSelectedLabels: true,
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Color.fromRGBO(2, 5, 4, 1.0),
      fontFamily: 'Poppins',
    ),
    titleMedium: TextStyle(
      color: Color.fromRGBO(2, 5, 4, 1.0),
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    ),
    headlineSmall: TextStyle(
      color: Color.fromRGBO(2, 5, 4, 1.0),
      fontWeight: FontWeight.w900,
      fontFamily: 'Poppins',
    ),
  ),
);

final ThemeData darkMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF4CAF50),
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF4CAF50),
    secondary: Color(0xFF87CEEB),
    tertiary: Color(0xFF2ECC71),
    error: Colors.redAccent,
    surface: Color(0xFF1E1E1E),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4CAF50),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFFFF8C00),
    contentTextStyle: const TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    hintStyle: const TextStyle(color: Colors.white38),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.all(16),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Color(0xFF4CAF50),
    selectedLabelStyle: TextStyle(color: Colors.red),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    showSelectedLabels: true,
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.white,
      fontFamily: 'Poppins',
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: 'Poppins',
    ),
  ),
);
