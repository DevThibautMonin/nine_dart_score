import 'package:isar/isar.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/database.dart';
import 'package:nine_dart_score/data/entities/game/game.dart';
import 'package:nine_dart_score/data/entities/player/player_embedded.dart';

class GameLocalDatasource {
  Database database = getIt.get();

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
}
