import 'package:nine_dart_score/features/game/data/entities/player/player_embedded.dart';
import 'package:nine_dart_score/features/game/data/entities/turn/turn.dart';
class Game {
  final int? id;
  final String? name;
  final List<PlayerEmbedded>? players;
  final int targetScore;
  final List<Turn>? turns;
  final int? turnNumber;

  const Game({
    this.id,
    this.name,
    this.players,
    required this.targetScore,
    this.turns,
    this.turnNumber,
  });
}
