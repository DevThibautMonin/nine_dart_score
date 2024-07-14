import 'package:flutter/material.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
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
