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
      ));
}
