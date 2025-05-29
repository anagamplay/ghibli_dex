import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF3452FF);
  static const secondary = Color(0xFF03DAC6);
  static const background = Colors.black;
  static const surface = Colors.white;
  static const error = Color(0xFFB00020);
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.black;
  static const onBackground = Colors.black;
  static const onSurface = Colors.black;
  static const onError = Colors.white;
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onSurface: AppColors.onSurface,
    onError: AppColors.onError,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.background,
    surfaceTintColor: AppColors.background,
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    )
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.primary,
  )
);
