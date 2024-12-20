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
              fontFamily: 'WorkSans',
              fontSize: 96,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 40,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 96,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.black),
            bodyMedium: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.black),
            bodySmall: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.black)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'WorkSans',
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
              fontFamily: 'WorkSans',
              fontSize: 96,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 40,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 96,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.white),
            bodyMedium: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            bodySmall: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
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
