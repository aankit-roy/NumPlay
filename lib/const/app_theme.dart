import 'package:flutter/material.dart';
import 'package:num_play/const/text_sizes.dart';

import 'app_colors.dart';



class AppTheme {
  // Light Theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(


      colorScheme: const ColorScheme.light(
        primary: AppColors.primary, // Primary color
        secondary: AppColors.secondary, // Accent color
        tertiary: AppColors.tertiary, // Additional accent
        surface: Colors.white, // Surface elements like cards
        onPrimary: AppColors.iconColor, // Text/icons on primary elements
        onSecondary: Colors.black, // Text/icons on secondary elements
        onSurface: AppColors.textPrimary, // Text/icons on surface
        error: AppColors.error, // Error color
      ),
      scaffoldBackgroundColor: AppColors.background, // Default scaffold background
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background, // App bar background
        foregroundColor: AppColors.textPrimary, // Text/icons in app bar
        elevation: 0, // Flat app bar for modern look
        iconTheme: IconThemeData(color: AppColors.iconColor), // App bar icons
      ),
      textTheme: TextTheme(
        // Display Sizes
        displayLarge: TextStyle(
          fontSize: TextSizes.displayLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: TextSizes.displayMedium,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: TextSizes.displaySmall,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Headline Sizes
        headlineLarge: TextStyle(
          fontSize: TextSizes.headlineLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: TextSizes.headlineMedium,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: TextSizes.headlineSmall,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Title Sizes
        titleLarge: TextStyle(
          fontSize: TextSizes.titleLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: TextSizes.titleMedium,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: TextSizes.titleSmall,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Body Sizes
        bodyLarge: TextStyle(
          fontSize: TextSizes.bodyLarge,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: TextSizes.bodyMedium,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: TextSizes.bodySmall,
          color: AppColors.textPrimary,
        ),

        // Label Sizes (e.g., for buttons, captions, overlines)
        labelLarge: TextStyle(
          fontSize: TextSizes.labelLarge,
          color: AppColors.textSecondary,
        ),
        labelMedium: TextStyle(
          fontSize: TextSizes.labelMedium,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: TextSizes.labelSmall,
          color: AppColors.textSecondary,
        ),
      ),
      buttonTheme: ButtonThemeData(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          buttonColor: AppColors.accent
        // textTheme: ButtonTextTheme.primary,
      ),


      // titleTextStyle: TextStyle(
      //   fontSize: TextSizes.titleLarge,
      //   fontWeight: FontWeight.bold,
      //   color: AppColors.textPrimary,
      // ),
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   actionsIconTheme: const IconThemeData(color: Colors.black),
      //   toolbarTextStyle: TextStyle(
      //     fontSize: TextSizes.bodyMedium,
      //     color: AppColors.textPrimary,
      //   ),
      // ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary, // Accent color
        tertiary: AppColors.tertiary,
        surface: Colors.grey.shade800,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black, // Dark Scaffold Background
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: TextSizes.displayLarge ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: TextSizes.displayMedium ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: TextSizes.displaySmall ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        headlineLarge: TextStyle(
          fontSize: TextSizes.headlineLarge ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: TextSizes.headlineMedium ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontSize: TextSizes.headlineSmall ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        titleLarge: TextStyle(
          fontSize: TextSizes.titleLarge ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: TextSizes.titleMedium,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: TextSizes.titleSmall ,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        bodyLarge: TextStyle(
          fontSize: TextSizes.bodyLarge ,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: TextSizes.bodyMedium ,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: TextSizes.bodySmall ,
          color: Colors.white,
        ),

        labelLarge: TextStyle(
          fontSize: TextSizes.labelLarge,
          color: Colors.white70,
        ),
        labelMedium: TextStyle(
          fontSize: TextSizes.labelMedium,
          color: Colors.white70,
        ),
        labelSmall: TextStyle(
          fontSize: TextSizes.labelSmall,
          color: Colors.white70,
        ),
      ),
      // buttonTheme: ButtonThemeData(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      //   buttonColor: AppColors.primary,
      //   textTheme: ButtonTextTheme.primary,
      // ),
      // appBarTheme: AppBarTheme(
      //   elevation: 4,
      //   titleTextStyle: TextStyle(
      //     fontSize: TextSizes.titleLarge ,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   actionsIconTheme: const IconThemeData(color: Colors.white),
      //   toolbarTextStyle: TextStyle(
      //     fontSize: TextSizes.bodyMedium ,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}