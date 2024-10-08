import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: const BorderSide(color: AppColors.neutral),
  );
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: AppColors.surface,
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: Colors.black,
      onSecondary: AppColors.backgroundDarkCard,
      onSurface: AppColors.onSurface,
      onError: AppColors.onError,
      brightness: Brightness.light,
      tertiary: AppColors.neutral,
      onTertiary: AppColors.onSurface,
      surfaceContainer: Color(0xFFEEEEEE),
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
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.shade),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: AppColors.onSurface,
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
      tertiary: AppColors.neutral,
      onTertiary: Colors.white,
      surfaceContainer: AppColors.backgroundDarkCard,
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
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.shade),
      ),
    ),
  );
}
