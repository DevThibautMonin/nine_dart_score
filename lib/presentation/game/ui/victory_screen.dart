import 'package:flutter/material.dart';
import 'package:nine_dart_score/core/commons/constants.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/presentation/tabs_screen/tabs_screen.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class VictoryScreen extends StatelessWidget {
  final PlayerEntity? player;

  const VictoryScreen({
    super.key,
    this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.gapH20,
              const Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.amber,
              ),
              Gaps.gapH20,
              const Text(
                Constants.congratulations,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.gapH10,
              Text(
                "${player?.name} gagne la partie !",
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: Constants.mainMenu,
                      onPressed: () async {
                        await Navigator.of(context).pushAndRemoveUntil(
                          createRouteWithTransition(
                            child: const TabsScreen(
                              selectedTabIndex: 0,
                            ),
                            direction: TransitionDirection.fromBottom,
                          ),
                          (Route route) => false,
                        );
                      },
                    ),
                  ),
                  Gaps.gapW10,
                  Expanded(
                    child: CustomButton(
                      text: Constants.statistics,
                      onPressed: () async {
                        await Navigator.of(context).pushAndRemoveUntil(
                          createRouteWithTransition(
                            child: const TabsScreen(
                              selectedTabIndex: 1,
                            ),
                            direction: TransitionDirection.fromBottom,
                          ),
                          (Route route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gaps.gapH25,
            ],
          ),
        ),
      ),
    );
  }
}
