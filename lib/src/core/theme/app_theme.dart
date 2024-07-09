import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: const ColorScheme(
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
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.headline1,
        displayMedium: AppTextStyles.headline2,
        displaySmall: AppTextStyles.headline3,
        headlineMedium: AppTextStyles.headline4,
        headlineSmall: AppTextStyles.headline5,
        titleLarge: AppTextStyles.headline6,
        titleMedium: AppTextStyles.subtitle1,
        titleSmall: AppTextStyles.subtitle2,
        bodyLarge: AppTextStyles.bodyText1,
        bodyMedium: AppTextStyles.bodyText2,
        labelLarge: AppTextStyles.button,
        bodySmall: AppTextStyles.caption,
        labelSmall: AppTextStyles.overline,
      ),
    );
  }
}
