import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          secondary: Colors.black,
          surface: Color(0xFFF1F2F3),
        ),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 90,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            headlineSmall: TextStyle(
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
                fontSize: 96,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.black),
            bodyMedium: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.black),
            bodySmall: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF4A3780),
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: const IconThemeData(color: Colors.black));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4E505F),
          secondary: Colors.white,
          surface: Color(0xFF17171C),
        ),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 90,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            headlineSmall: TextStyle(
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
                fontSize: 96,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            bodySmall: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF4A3780),
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}
