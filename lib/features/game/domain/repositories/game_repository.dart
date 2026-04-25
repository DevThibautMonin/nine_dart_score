import 'package:nine_dart_score/features/game/domain/entities/game/game.dart';
import 'package:nine_dart_score/features/game/domain/entities/turn/turn.dart';

abstract class IGameRepository {
  Future<GameEntity?> createGame(GameEntity gameEntity);
  Future<GameEntity?> updateGame(
    int gameId,
    int playerId,
    int newScore,
    TurnEntity turn,
    int turnNumber,
  );
  Future<List<GameEntity>?> getGames();
  Future<void> deleteGame(int gameId);
}
