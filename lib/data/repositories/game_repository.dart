import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/datasources/local/game_local_datasource.dart';
import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/mappers/game_mapper.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/data/mappers/turn_mapper.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';

@Injectable()
class GameRepository {
  final GameLocalDatasource gameLocalDatasource;

  const GameRepository({
    required this.gameLocalDatasource,
  });

  Future<GameEntity?> createGame(GameEntity gameEntity) async {
    final game = Game(
      targetScore: gameEntity.targetScore,
      name: gameEntity.name,
      turns: gameEntity.turns?.map((turn) => TurnMapper.toData(turn)).toList(),
    );
    final players = gameEntity.players?.map((e) => PlayerMapper.toEmbedded(e)).toList();

    var result = await gameLocalDatasource.createGame(game, players);
    if (result != null) {
      return GameMapper.toEntity(result);
    } else {
      throw Exception("La partie n'existe pas.");
    }
  }

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

  Future<List<GameEntity>?> getGames() async {
    var games = await gameLocalDatasource.getGames();
    final gamesEntity = games?.map((e) => GameMapper.toEntity(e)).toList();
    return gamesEntity;
  }

  Future<void> deleteGame(int gameId) async {
    await gameLocalDatasource.deleteGame(gameId);
  }
}
