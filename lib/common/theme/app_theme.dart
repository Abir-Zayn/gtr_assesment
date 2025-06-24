import 'package:flutter/material.dart';

// app primary color = 2EC0F9
// app button color = 0CF574
// app dark color =  0C1B33

const Color primaryColor = Color(0xFF2EC0F9);
const Color appLightBtnColor = Color(0xFFFFD23F);
const Color appLightTextColor = Color(0xFF000000);

const Color appDarkColor = Color(0xFF0C1B33);
const Color appDarkBtnColor = Color(0xFF8C8A93);
const Color appDarkTextColor = Color(0xFFFFFFFF);

// Light and Dark Theme Data
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: appLightBtnColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.transparent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appLightBtnColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: BorderSide(color: Colors.grey.shade300),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: primaryColor),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appDarkColor,
    brightness: Brightness.dark,
    primary: appDarkColor,
    secondary: appDarkBtnColor,
    surface: appDarkColor,
  ),
  scaffoldBackgroundColor: appDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appDarkBtnColor,
      foregroundColor: appDarkTextColor,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: appDarkTextColor,
      side: BorderSide(color: Colors.grey.shade600),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: primaryColor),
  ),
);
