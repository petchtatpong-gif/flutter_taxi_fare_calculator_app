import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryYellow = Color(0xFFFFD700);
  static const Color secondaryGrey = Color(0xFF9E9E9E);
  static const Color backgroundWhite = Colors.white;

  static ThemeData get taxiTheme {
    return ThemeData(
      primaryColor: primaryYellow,
      scaffoldBackgroundColor: backgroundWhite,
      colorScheme: ColorScheme.light(
        primary: primaryYellow,
        secondary: secondaryGrey,
        surface: backgroundWhite,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryYellow,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
