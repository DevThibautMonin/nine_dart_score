import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';

class GameEntity {
  final int? id;
  final String? name;
  final List<PlayerEntity>? players;
  final int targetScore;
  final List<TurnEntity>? turns;
  final int? turnNumber;

  GameEntity({
    this.id,
    this.players,
    required this.targetScore,
    this.turns,
    this.name,
    this.turnNumber,
  });
}
