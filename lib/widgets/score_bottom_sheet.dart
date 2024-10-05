import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class ScoreBottomSheet extends StatelessWidget {
  final GameBloc gameBloc;

  const ScoreBottomSheet({
    super.key,
    required this.gameBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.leaderboard,
                  color: CustomColors.primaryBlue,
                ),
                Gaps.gapW10,
                Text(
                  "Scores",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gameBloc.state.players.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: gameBloc.state.game?.players?[index].color),
                      Gaps.gapW10,
                      Text(
                        "${gameBloc.state.game?.players?[index].name}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Text("${gameBloc.state.game?.players?[index].score}"),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
