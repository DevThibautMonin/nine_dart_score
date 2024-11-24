import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/commons/constants.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/enums/classic_game_enum.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/presentation/game/ui/empty_players_screen.dart';
import 'package:nine_dart_score/presentation/game/ui/game_screen.dart';
import 'package:nine_dart_score/presentation/game/ui/player_settings_chip.dart';
import 'package:nine_dart_score/presentation/game/ui/target_score_chip.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/custom_textfield.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  final GameBloc _gameBloc = getIt.get();
  final TextEditingController _gameNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _gameBloc
        ..add(GetGameData())
        ..add(SelectTargetScore(targetScore: ClassicGameEnum.points301)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Classique"),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                if (state.allPlayers.isEmpty) {
                  return const EmptyPlayersScreen();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        controller: _gameNameController,
                        labelText: "Nom de la partie*",
                        onChanged: (value) {
                          _gameBloc.add(GameNameChangedEvent(gameName: value));
                        },
                      ),
                      Gaps.gapH15,
                      const Text(
                        "Nombre de points à faire",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: ClassicGameEnum.values.map((gameType) {
                          return BlocBuilder<GameBloc, GameState>(
                            buildWhen: (previous, current) => previous.targetScore != current.targetScore,
                            builder: (context, state) {
                              return TargetScoreChip(
                                label: gameType.score.toString(),
                                isSelected: state.targetScore == gameType,
                                onSelected: () {
                                  _gameBloc.add(SelectTargetScore(targetScore: gameType));
                                },
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Gaps.gapH15,
                      const Text(
                        Constants.players,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<GameBloc, GameState>(
                        buildWhen: (previous, current) => previous.players != current.players || previous.allPlayers != current.allPlayers,
                        builder: (context, state) {
                          return SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.allPlayers.length,
                              itemBuilder: (context, index) {
                                final allPlayers = state.allPlayers;
                                final isSelected = state.players.contains(allPlayers[index]);
                                if (allPlayers.isNotEmpty) {
                                  return PlayerSettingsChip(
                                    player: state.allPlayers[index],
                                    isSelected: isSelected,
                                    onSelected: (selected) {
                                      if (selected) {
                                        _gameBloc.add(AddPlayerEvent(player: allPlayers[index]));
                                      } else {
                                        _gameBloc.add(RemovePlayerEvent(player: allPlayers[index]));
                                      }
                                    },
                                  );
                                } else {
                                  return const Text("Pour pouvoir jouer, veuillez d'abord créer des joueurs !");
                                }
                              },
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          return CustomButton(
                            isEnabled: state.isFormValid(),
                            text: Constants.start,
                            onPressed: () async {
                              await Navigator.of(context).pushAndRemoveUntil(
                                createRouteWithTransition(
                                  direction: TransitionDirection.fromDiagBottomRight,
                                  child: GameScreen(
                                    gameBloc: _gameBloc
                                      ..add(
                                        StartGameEvent(gameName: _gameNameController.text),
                                      ),
                                  ),
                                ),
                                (Route route) => false,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
