import 'package:flutter/material.dart';

ThemeData customDarkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6200EE), // Vibrant Indigo
    secondary: Color(0xFFFFC107), // Amber
    surface: Color(0xFF1E1E2C), // Deep Navy
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Color(0xFFD1D1E0),
    error: Color(0xFFCF6679),
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(
      255, 43, 42, 42), // Set a custom Scaffold background color

  cardTheme: CardTheme(
    color: const Color.fromARGB(
        255, 87, 86, 86), // Slightly lighter than Scaffold for contrast
    elevation: 4,
    shadowColor: // Colors.black.withOpacity(0.100),
        Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF2C2C38),
    titleTextStyle: TextStyle(
      color: Color(0xFFE0E0FF),
      fontFamily: 'PlaywriteAUSA',
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    iconTheme: IconThemeData(color: Color(0xFFE0E0FF)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6200EE),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFFE0E0FF),
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'PlaywriteAUSA'),
    bodyLarge: TextStyle(
        color: Color(0xFFD1D1E0), fontSize: 16, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Color(0xFFB0B0C0), fontSize: 14),
  ),
);