import 'package:flutter/material.dart';
import 'package:nine_dart_score/core/commons/constants.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/presentation/tabs_screen/tabs_screen.dart';
import 'package:nine_dart_score/themes/dark_theme.dart';
import 'package:nine_dart_score/themes/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appTitle,
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
