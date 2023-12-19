import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppTheme {
  static darkTheme() => ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: white,
          ),
          displayMedium: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: white,
          ),
          headlineMedium: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          headlineSmall: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: blue,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: bodyLargeTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
        ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )
        ),
      );
}
