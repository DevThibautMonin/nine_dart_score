import 'package:nine_dart_score/data/entities/player/player.dart';
import 'package:nine_dart_score/data/entities/player/player_embedded.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';

class PlayerMapper {
  static Player toData(PlayerEntity entity) {
    return Player(
      name: entity.name,
      id: entity.id,
      score: entity.score,
    );
  }

  static PlayerEmbedded toEmbedded(PlayerEntity entity) {
    return PlayerEmbedded(
      name: entity.name,
      id: entity.id,
      score: entity.score,
    );
  }

  static PlayerEntity toEntityFromEmbedded(PlayerEmbedded data) {
    return PlayerEntity(
      name: data.name,
      id: data.id,
      score: data.score,
    );
  }

  static PlayerEntity toEntityFromData(Player data) {
    return PlayerEntity(
      name: data.name,
      id: data.id,
      score: data.score,
    );
  }
}
