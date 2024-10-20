import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/enums/classic_game_enum.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
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
  ClassicGameEnum _selectedGameType = ClassicGameEnum.points301;
  final TextEditingController _gameNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _gameBloc
        ..add(GetGameData())
        ..add(SelectTargetScore(targetScore: _selectedGameType.score)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Classique"),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                  controller: _gameNameController,
                  labelText: "Nom de la partie*",
                  onChanged: (value) {
                    _gameBloc.add(GameNameChangedEvent(gameName: value));
                  },
                ),
                const Text(
                  "Nombre de points",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: ClassicGameEnum.values.map((gameType) {
                    return TargetScoreChip(
                      label: gameType.score.toString(),
                      isSelected: _selectedGameType == gameType,
                      onSelected: () {
                        setState(() {
                          _selectedGameType = gameType;
                        });
                        _gameBloc.add(SelectTargetScore(targetScore: gameType.score));
                      },
                    );
                  }).toList(),
                ),
                Gaps.gapH15,
                const Text(
                  "Joueurs",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.allPlayers?.length,
                        itemBuilder: (context, index) {
                          final allPlayers = state.allPlayers;
                          final isSelected = state.players.contains(allPlayers?[index]);
                          if (allPlayers != null && allPlayers.isNotEmpty) {
                            return PlayerSettingsChip(
                              player: state.allPlayers?[index],
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
                            return null;
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
                      text: "Commencer",
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
            ),
          ),
        ),
      ),
    );
  }
}
