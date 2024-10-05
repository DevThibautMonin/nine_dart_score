import 'package:flutter/material.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class HistoryPlayerStats extends StatelessWidget {
  final GameEntity game;
  final PlayerEntity? currentPlayer;

  const HistoryPlayerStats({
    super.key,
    required this.game,
    required this.currentPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final playerTurns = game.turns?.where((turn) => turn.playerId == currentPlayer?.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistiques de ${currentPlayer?.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Score à atteindre ${game.targetScore}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Score réalisé ${_calculateTotalScore(playerTurns)}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playerTurns?.length ?? 0,
              itemBuilder: (context, index) {
                final turn = playerTurns![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tour ${index + 1}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Gaps.gapH10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: turn.throws!.map((throwEntity) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(
                                  label: Text(
                                    "${throwEntity.value}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  backgroundColor: Colors.blue.shade100,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _calculateTotalScore(List<TurnEntity>? turns) {
    if (turns == null || turns.isEmpty) return 0;
    int totalScore = 0;
    for (var turn in turns) {
      for (var throwEntity in turn.throws!) {
        totalScore += throwEntity.value;
      }
    }
    return totalScore;
  }
}
