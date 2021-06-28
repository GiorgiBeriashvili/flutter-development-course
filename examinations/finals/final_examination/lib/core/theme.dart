import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const accentColor = Color(0xFF0ECC57);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const primaryColor = Color(0xFF6CB4B1);
  static const primaryColorDark = Color(0xFF04A3A3);
  static const primaryColorLight = Color(0xFF66C7C7);

  static ThemeData themeData(BuildContext context) =>
      Theme.of(context).copyWith(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      );
}
