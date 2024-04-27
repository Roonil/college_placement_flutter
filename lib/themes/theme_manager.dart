import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData getTheme({
    required ThemeMode themeMode,
    required Color primaryColor,
    required Color? secondaryColor,
    required Color? tertiaryColor,
  }) {
    final ThemeData baseThemeData = ThemeData(
      chipTheme: ChipThemeData(
        side: const BorderSide(color: Colors.transparent),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final ThemeData lightThemeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        brightness: Brightness.light,
      ),
      primaryColor: primaryColor,
      useMaterial3: true,
    );

    final ThemeData darkThemeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        brightness: Brightness.dark,
      ),
      primaryColor: primaryColor,
      useMaterial3: true,
    );

    final ThemeData darkTheme = darkThemeData.copyWith(
      cardTheme: darkThemeData.cardTheme
          .copyWith(shadowColor: primaryColor, elevation: 5),
      scaffoldBackgroundColor: const Color.fromRGBO(20, 22, 34, 1),
      colorScheme: darkThemeData.colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
      ),
      chipTheme: baseThemeData.chipTheme.copyWith(
        side: const BorderSide(color: Colors.transparent),
        backgroundColor: secondaryColor,
        selectedColor: secondaryColor,
        selectedShadowColor: primaryColor,
        labelStyle: const TextStyle(color: Colors.white),
        iconTheme:
            darkThemeData.iconTheme.copyWith(color: secondaryColor, size: 18),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkThemeData.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );

    final ThemeData theme = themeMode == ThemeMode.light
        ? lightThemeData.copyWith(
            appBarTheme:
                darkTheme.appBarTheme.copyWith(foregroundColor: Colors.white),
            colorScheme: lightThemeData.colorScheme,
            scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
            cardTheme: lightThemeData.cardTheme.copyWith(elevation: 5),
            elevatedButtonTheme: darkTheme.elevatedButtonTheme,
            chipTheme: darkTheme.chipTheme,
            textTheme: GoogleFonts.poppinsTextTheme(lightThemeData.textTheme))
        : darkTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(darkThemeData.textTheme));

    return theme;
  }
}
