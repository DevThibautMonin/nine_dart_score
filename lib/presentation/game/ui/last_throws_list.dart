import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class LastThrowsList extends StatelessWidget {
  const LastThrowsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        var currentPlayerId = state.game?.players?[state.currentPlayerIndex].id;

        if (state.game?.turns?.isEmpty ?? true) {
          return const Center(
            child: Text(
              "Aucun lancer pour l'instant !",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: state.game?.turns?.length,
          itemBuilder: (context, index) {
            final turn = state.game?.turns?[index];

            if (turn?.playerId != currentPlayerId) {
              return const SizedBox();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [CustomColors.primaryBlue.withOpacity(0.8), Colors.blueAccent.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildScoreItem(turn?.throws?.first.value ?? 0, Icons.filter_1_sharp),
                      _buildScoreItem(turn?.throws?.elementAt(1).value ?? 0, Icons.filter_2_sharp),
                      _buildScoreItem(turn?.throws?.last.value ?? 0, Icons.filter_3_sharp),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildScoreItem(int score, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: Colors.white,
        ),
        Gaps.gapH5,
        Text(
          "$score",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
