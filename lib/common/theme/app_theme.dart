import 'package:flutter/material.dart';

// app primary color = 2EC0F9
// app button color = 0CF574
// app dark color =  0C1B33

final Color primaryColor = const Color(0xFF2EC0F9);
final Color appLightBtnColor =  const Color(0xFF0CF574);
final Color appDarkColor = const Color(0xFF0C1B33);
final Color appDarkBtnColor = const Color(0xFF8C8A93);

// Light and Dark Theme Data
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: appLightBtnColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: appLightBtnColor,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: appDarkColor,
  scaffoldBackgroundColor: appDarkColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appDarkColor,
    primary: appDarkColor,
    secondary: appDarkBtnColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: appDarkColor,
    foregroundColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: appDarkBtnColor,
    textTheme: ButtonTextTheme.primary,
  ),
);