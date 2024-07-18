import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nine_dart_score/presentation/game/ui/game_screen.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                "9 Dart Score",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: CustomColors.primaryBlue,
                ),
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: SvgPicture.asset("assets/dart_target.svg"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(createRouteWithTransition(child: const GameScreen()));
                },
                child: const Text("Classique (501 / 301)"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
