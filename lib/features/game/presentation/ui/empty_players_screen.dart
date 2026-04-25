import 'package:flutter/material.dart';
import 'package:nine_dart_score/features/navigation/presentation/tabs_screen.dart';
import 'package:nine_dart_score/shared/presentation/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/shared/presentation/widgets/custom_button.dart';
import 'package:nine_dart_score/shared/presentation/widgets/gaps.dart';

class EmptyPlayersScreen extends StatelessWidget {
  const EmptyPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Pour commencer à jouer, veuillez d'abord créer au minimum 1 joueur !",
          textAlign: TextAlign.center,
        ),
        Gaps.gapH10,
        CustomButton(
          text: "Créer un joueur",
          onPressed: () async {
            await Navigator.of(context).pushAndRemoveUntil(
              createRouteWithTransition(
                direction: TransitionDirection.fromDiagBottomRight,
                child: const TabsScreen(
                  selectedTabIndex: 2,
                ),
              ),
              (Route route) => false,
            );
          },
        ),
      ],
    );
  }
}
