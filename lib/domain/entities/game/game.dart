import 'package:dart_mappable/dart_mappable.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';

part 'game.mapper.dart';

@MappableClass()
class GameEntity with GameEntityMappable {
  final int? id;
  final List<PlayerEntity>? players;
  final int targetScore;
  final List<TurnEntity>? turns;

  GameEntity({
    this.id,
    this.players,
    required this.targetScore,
    this.turns,
  });
}
