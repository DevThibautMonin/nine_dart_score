import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:nine_dart_score/data/database.dart';
import 'package:nine_dart_score/data/entities/player/player.dart';

@LazySingleton()
class PlayerLocalDatasource {
  final Database database;

  const PlayerLocalDatasource({
    required this.database,
  });

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
