import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.nunitoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.primaryBlue,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
  ),
);
