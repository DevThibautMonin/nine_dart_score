import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/data/mappers/turn_mapper.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

class GameMapper {
  static Game toData(GameEntity entity) {
    return Game(
      targetScore: entity.targetScore,
      id: entity.id,
      name: entity.name,
      players: entity.players?.map((player) => PlayerMapper.toEmbedded(player)).toList(),
      turns: entity.turns?.map((turn) => TurnMapper.toData(turn)).toList(),
      turnNumber: entity.turnNumber,
    );
  }

  static GameEntity toEntity(Game data) {
    return GameEntity(
      targetScore: data.targetScore,
      id: data.id,
      name: data.name,
      players: data.players?.map((player) => PlayerMapper.toEntityFromEmbedded(player)).toList(),
      turns: data.turns?.map((turn) => TurnMapper.toEntity(turn)).toList(),
      turnNumber: data.turnNumber,
    );
  }
}
