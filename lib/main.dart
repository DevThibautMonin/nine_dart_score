import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/tabs_screen/tabs_screen.dart';
import 'package:nine_dart_score/themes/dark_theme.dart';
import 'package:nine_dart_score/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '9 Dart Score',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Scaffold(
        body: SafeArea(
          child: TabsScreen(),
        ),
      ),
    );
  }
}
