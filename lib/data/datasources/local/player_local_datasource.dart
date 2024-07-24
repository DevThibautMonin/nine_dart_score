import 'package:isar/isar.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/database.dart';
import 'package:nine_dart_score/data/entities/player/player.dart';

class PlayerLocalDatasource {
  Database database = getIt.get();

  Future createPlayer(Player player) async {
    final db = await database.database;
    await db.writeTxn(() async {
      await db.players.put(player);
    });
  }

  Future<List<Player>> getPlayers() async {
    final db = await database.database;
    return await db.players.where().findAll();
  }

  Future deletePlayer(int playerId) async {
    final db = await database.database;
    await db.writeTxn(() async {
      await db.players.delete(playerId);
    });
  }
}
