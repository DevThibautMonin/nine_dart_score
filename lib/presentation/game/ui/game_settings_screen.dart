import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/presentation/game/ui/player_chip.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  final GameBloc _gameBloc = getIt.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _gameBloc..add(GetGameData()),
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
                const Text(
                  "Nombre de points",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Row(
                  children: [
                    Chip(label: Text("301")),
                    Gaps.gapW10,
                    Chip(label: Text("501")),
                  ],
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
                          final isSelected = state.players?.contains(allPlayers?[index]) ?? false;
                          if (allPlayers != null && allPlayers.isNotEmpty) {
                            return PlayerChip(
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
                CustomButton(
                  text: "Créer",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
