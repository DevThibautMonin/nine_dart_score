import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/datasources/local/game_local_datasource.dart';
import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/mappers/game_mapper.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

class GameRepository {
  final GameLocalDatasource _gameLocalDatasource = getIt.get();

  Future<GameEntity?> createGame(GameEntity gameEntity) async {
    final game = Game(targetScore: gameEntity.targetScore);
    final players = gameEntity.players?.map((e) => PlayerMapper.toEmbedded(e)).toList();

    var result = await _gameLocalDatasource.createGame(game, players);
    if (result != null) {
      return GameMapper.toEntity(result);
    } else {
      throw Exception("La partie n'existe pas.");
    }
  }
}
