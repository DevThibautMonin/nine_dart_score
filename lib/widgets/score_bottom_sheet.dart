import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
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
          const Text(
            "Scores",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.gapH15,
          Expanded(
            child: ListView.builder(
              itemCount: gameBloc.state.players.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("${gameBloc.state.game?.players?[index].name}"),
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
