import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/shared/data/datasources/local/database.dart';
import 'package:nine_dart_score/features/players/data/entities/player/player.dart';
import 'package:drift/drift.dart';

@LazySingleton()
class PlayerLocalDatasource {
  final Database database;

  const PlayerLocalDatasource({
    required this.database,
  });

  Future<void> createPlayer(Player player) async {
    await database.into(database.playersTable).insert(
          PlayersTableCompanion.insert(
            name: Value(player.name),
            score: Value(player.score),
            color: Value(player.color),
          ),
        );
  }

  Future<List<Player>> getPlayers() async {
    final playerRows = await (database.select(database.playersTable)
          ..orderBy([(table) => OrderingTerm(expression: table.id)]))
        .get();

    return playerRows
        .map(
          (playerRow) => Player(
            id: playerRow.id,
            name: playerRow.name,
            score: playerRow.score,
            color: playerRow.color,
          ),
        )
        .toList();
  }

  Future<void> deletePlayer(int playerId) async {
    await (database.delete(database.playersTable)
          ..where((table) => table.id.equals(playerId)))
        .go();
  }
}
