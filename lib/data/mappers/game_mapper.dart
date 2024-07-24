import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

class GameMapper {
  static Game toData(GameEntity entity) {
    final game = Game(targetScore: entity.targetScore);
    if (entity.players != null) {
      for (var playerEntity in entity.players!) {
        final player = PlayerMapper.toEmbedded(playerEntity);
        game.players?.add(player);
      }
    }
    return game;
  }

  static GameEntity toEntity(Game data) {
    final players = data.players?.map((player) => PlayerMapper.toEntityFromEmbedded(player)).toList();

    return GameEntity(
      id: data.id,
      players: players,
      targetScore: data.targetScore,
    );
  }
}
