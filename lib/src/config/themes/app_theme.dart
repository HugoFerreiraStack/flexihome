
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData base = ThemeData.light();
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,

    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    ),
  );
}