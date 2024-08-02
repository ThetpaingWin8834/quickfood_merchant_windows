import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/config/constants/app_colors.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme:
        ColorScheme.fromSeed(seedColor: AppColors.appPrimaryColor).copyWith(
      primary: AppColors.appPrimaryColor,
    ),
    elevatedButtonTheme: lightElevatedButtonTheme,
  );

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(55),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.appPrimaryColor,
          // disabledBackgroundColor: Colors.grey,
          // disabledForegroundColor: Colors.grey,
          // side: const BorderSide(color: Colors.blue),
          // // padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
