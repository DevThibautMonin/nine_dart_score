import 'package:isar/isar.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/database.dart';
import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/entities/player/player_embedded.dart';
import 'package:nine_dart_score/data/entities/turn/turn.dart';

class GameLocalDatasource {
  Database database = getIt.get();

  Future<void> deleteGame(int gameId) async {
    final db = await database.database;

    await db.writeTxn(() async {
      await db.games.delete(gameId);
    });
  }

  Future<Game?> createGame(Game game, List<PlayerEmbedded>? players) async {
    final db = await database.database;
    return db.writeTxn(() async {
      final newGameId = await db.games.put(game);
      var newGame = await db.games.get(newGameId);
      if (players != null) {
        for (var player in players) {
          player.score = game.targetScore;
        }
        newGame?.players = players;
        if (newGame != null) {
          await db.games.put(newGame);
        }
      }
      return await db.games.where().idEqualTo(newGameId).findFirst();
    });
  }

  Future<Game?> updateGame(int gameId, int playerId, int newScore, Turn turn) async {
    final db = await database.database;
    return db.writeTxn(() async {
      var game = await db.games.get(gameId);
      if (game != null && game.players != null) {
        var currentTurns = game.turns?.toList();
        currentTurns?.add(turn);
        game.turns = currentTurns;
        for (var player in game.players!) {
          if (player.id == playerId) {
            player.score = newScore;
            break;
          }
        }
        await db.games.put(game);
      }
      return await db.games.where().idEqualTo(gameId).findFirst();
    });
  }

  Future<List<Game>?> getGames() async {
    final db = await database.database;

    return db.writeTxn(() async {
      return db.games.where().findAll();
    });
  }
}
