import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/data/datasources/local/game_local_datasource.dart';
import 'package:nine_dart_score/features/game/data/mappers/game_mapper.dart';
import 'package:nine_dart_score/features/game/data/mappers/turn_mapper.dart';
import 'package:nine_dart_score/features/game/domain/entities/game/game.dart';
import 'package:nine_dart_score/features/game/domain/entities/turn/turn.dart';
import 'package:nine_dart_score/features/game/domain/repositories/game_repository.dart';

@LazySingleton(as: IGameRepository)
class GameRepository implements IGameRepository {
  final GameLocalDatasource gameLocalDatasource;

  const GameRepository({
    required this.gameLocalDatasource,
  });

  @override
  Future<GameEntity?> createGame(GameEntity gameEntity) async {
    final game = GameMapper.toData(gameEntity);

    var result = await gameLocalDatasource.createGame(game);
    if (result != null) {
      return GameMapper.toEntity(result);
    } else {
      throw Exception("La partie n'existe pas.");
    }
  }

  @override
  Future<GameEntity?> updateGame(int gameId, int playerId, int newScore, TurnEntity turn, int turnNumber) async {
    var mappedTurn = TurnMapper.toData(turn);
    var result = await gameLocalDatasource.updateGame(
      gameId,
      playerId,
      newScore,
      mappedTurn,
      turnNumber,
    );
    if (result != null) {
      return GameMapper.toEntity(result);
    } else {
      throw Exception("Impossible de mettre à jour le score du joueur.");
    }
  }

  @override
  Future<List<GameEntity>?> getGames() async {
    var games = await gameLocalDatasource.getGames();
    final gamesEntity = games.map((e) => GameMapper.toEntity(e)).toList();
    return gamesEntity;
  }

  @override
  Future<void> deleteGame(int gameId) async {
    await gameLocalDatasource.deleteGame(gameId);
  }
}
