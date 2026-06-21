import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.gold,
      scaffoldBackgroundColor: AppColors.black,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        surface: AppColors.black,
      ),
    );
  }
}
