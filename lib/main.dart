import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nine_dart_score/shared/core/commons/constants.dart';
import 'package:nine_dart_score/shared/core/di/injectable.dart';
import 'package:nine_dart_score/features/navigation/presentation/tabs_screen.dart';
import 'package:nine_dart_score/shared/presentation/themes/dark_theme.dart';
import 'package:nine_dart_score/shared/presentation/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
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
          child: TabsScreen(selectedTabIndex: 0),
        ),
      ),
    );
  }
}
