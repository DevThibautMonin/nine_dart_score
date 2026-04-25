import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nine_dart_score/shared/core/commons/constants.dart';
import 'package:nine_dart_score/shared/core/di/injectable.dart';
import 'package:nine_dart_score/firebase_options.dart';
import 'package:nine_dart_score/features/navigation/presentation/tabs_screen.dart';
import 'package:nine_dart_score/shared/presentation/themes/dark_theme.dart';
import 'package:nine_dart_score/shared/presentation/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    unawaited(FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails));
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
    return true;
  };

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
