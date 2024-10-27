import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/commons/constants.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/presentation/game/ui/last_throws_list.dart';
import 'package:nine_dart_score/presentation/game/ui/score_selection_button.dart';
import 'package:nine_dart_score/presentation/game/ui/victory_screen.dart';
import 'package:nine_dart_score/presentation/tabs_screen/tabs_screen.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/gaps.dart';
import 'package:nine_dart_score/widgets/score_bottom_sheet.dart';

class GameScreen extends StatelessWidget {
  final GameBloc gameBloc;

  const GameScreen({
    super.key,
    required this.gameBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: gameBloc,
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) async {
          if (state.hasGameEnded) {
            await Navigator.of(context).pushAndRemoveUntil(
              createRouteWithTransition(
                child: VictoryScreen(
                  player: state.winner,
                ),
                direction: TransitionDirection.fromDiagBottomRight,
              ),
              (Route route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return Text("${gameBloc.state.game?.name} ${state.firstScore}");
              },
            ),
            actions: [
              IconButton.outlined(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ScoreBottomSheet(
                        gameBloc: gameBloc,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.scoreboard,
                  color: CustomColors.primaryBlue,
                ),
              ),
              Gaps.gapW10,
              IconButton.outlined(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.orange,
                          size: 36,
                        ),
                        title: const Text("Attention"),
                        content: const Text("Êtes-vous sûr de vouloir quitter la partie en cours ?"),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: Constants.no,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Gaps.gapW15,
                              Expanded(
                                child: CustomButton(
                                  text: Constants.yes,
                                  onPressed: () async {
                                    gameBloc.add(DeleteGameEvent(gameId: gameBloc.state.game?.id));
                                    await Navigator.of(context).pushAndRemoveUntil(
                                      createRouteWithTransition(
                                        child: const TabsScreen(),
                                        direction: TransitionDirection.fromBottom,
                                      ),
                                      (Route route) => false,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
              ),
              Gaps.gapW10,
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tour n° ${state.turnNumber} : ${state.game?.players?[state.currentPlayerIndex].name}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gaps.gapH10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Score restant : ${state.game?.players?[state.currentPlayerIndex].score}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Derniers lancers",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Gaps.gapH10,
                          Expanded(
                            child: LastThrowsList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<GameBloc, GameState>(
                              buildWhen: (previous, current) => previous.firstScore != current.firstScore,
                              builder: (context, state) {
                                return ScoreSelectionButton(
                                  label: "Score 1",
                                  score: state.firstScore,
                                  onScoreSelected: (score) {
                                    gameBloc.add(UpdateFirstScore(score: score));
                                  },
                                );
                              },
                            ),
                          ),
                          Gaps.gapW10,
                          Expanded(
                            child: BlocBuilder<GameBloc, GameState>(
                              buildWhen: (previous, current) => previous.secondScore != current.secondScore,
                              builder: (context, state) {
                                return ScoreSelectionButton(
                                  label: "Score 2",
                                  score: state.secondScore,
                                  onScoreSelected: (score) {
                                    gameBloc.add(UpdateSecondScore(score: score));
                                  },
                                );
                              },
                            ),
                          ),
                          Gaps.gapW10,
                          Expanded(
                            child: BlocBuilder<GameBloc, GameState>(
                              buildWhen: (previous, current) => previous.thirdScore != current.thirdScore,
                              builder: (context, state) {
                                return ScoreSelectionButton(
                                  label: "Score 3",
                                  score: state.thirdScore,
                                  onScoreSelected: (score) {
                                    gameBloc.add(UpdateThirdScore(score: score));
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Joueur suivant",
                  onPressed: () {
                    gameBloc.add(
                      NextPlayerEvent(
                        firstThrow: state.firstScore ?? 0,
                        secondThrow: state.secondScore ?? 0,
                        thirdThrow: state.thirdScore ?? 0,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
