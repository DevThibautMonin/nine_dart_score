import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nine_dart_score/shared/core/commons/constants.dart';
import 'package:nine_dart_score/features/game/presentation/ui/game_settings_screen.dart';
import 'package:nine_dart_score/shared/presentation/themes/custom_colors.dart';
import 'package:nine_dart_score/shared/presentation/widgets/animations/route_animation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _scale = 0.1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    unawaited(_animationController.repeat(reverse: true));

    _animationController.addListener(() {
      setState(() {
        _scale = 1.0 + 0.3 * _animationController.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                Constants.appTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: CustomColors.primaryBlue,
                ),
              ),
              RepaintBoundary(
                child: AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: SvgPicture.asset(Constants.dartTargetAsset),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await Navigator.of(context).push(createRouteWithTransition(
                    child: const GameSettingsScreen(),
                    direction: TransitionDirection.fromDiagBottomRight,
                  ));
                },
                child: const Text("Classique (501 / 301)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
