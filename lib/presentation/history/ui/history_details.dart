import 'package:flutter/material.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/presentation/history/ui/history_details_item.dart';
import 'package:nine_dart_score/presentation/history/ui/history_player_stats.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class HistoryDetails extends StatelessWidget {
  final GameEntity gameEntity;

  const HistoryDetails({
    super.key,
    required this.gameEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Récapitulatif de la partie",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    gameEntity.name ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ),
              Gaps.gapH20,
              HistoryDetailsItem(
                title: "Score à atteindre",
                data: "${gameEntity.targetScore}",
              ),
              Gaps.gapH20,
              HistoryDetailsItem(
                title: "Nombre de tours",
                data: "${gameEntity.turnNumber}",
              ),
              Gaps.gapH20,
              const Text(
                "Joueurs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Gaps.gapH10,
              Expanded(
                child: ListView.builder(
                  itemCount: gameEntity.players?.length ?? 0,
                  itemBuilder: (context, index) {
                    final player = gameEntity.players?[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(createRouteWithTransition(
                          child: HistoryPlayerStats(
                            game: gameEntity,
                            currentPlayer: player,
                          ),
                          direction: TransitionDirection.fromRight,
                        ));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: CustomColors.primaryBlue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            player?.name ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: CustomColors.primaryBlue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
