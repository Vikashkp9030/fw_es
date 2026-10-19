import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF0754A5);
  static const navyDark = Color(0xFF073263);
  static const green = Color(0xFF16852D);
  static const orange = Color(0xFFF59E0B);
  static const background = Color(0xFFF5F7FA);
  static const ink = Color(0xFF172033);
  static const muted = Color(0xFF667085);
  static const line = Color(0xFFE6EAF0);
}

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.navy,
    primary: AppColors.navy,
    secondary: AppColors.green,
    surface: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Arial',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.ink, height: 1.65),
      bodyMedium: TextStyle(color: AppColors.ink, height: 1.6),
      bodySmall: TextStyle(color: AppColors.muted, height: 1.5),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.navy, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    ),
  );
}
