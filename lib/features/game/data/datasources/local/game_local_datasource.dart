import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'package:nine_dart_score/shared/data/datasources/local/database.dart';
import 'package:nine_dart_score/features/game/data/entities/game/game.dart';
import 'package:nine_dart_score/features/game/data/entities/player/player_embedded.dart';
import 'package:nine_dart_score/features/game/data/entities/throw/throw.dart';
import 'package:nine_dart_score/features/game/data/entities/turn/turn.dart';

@Injectable()
class GameLocalDatasource {
  final Database database;

  const GameLocalDatasource({
    required this.database,
  });

  Future<void> deleteGame(int gameId) async {
    await (database.delete(database.gamesTable)
          ..where((table) => table.id.equals(gameId)))
        .go();
  }

  Future<Game?> createGame(Game game) async {
    return database.transaction(() async {
      final gameId = await database.into(database.gamesTable).insert(
            GamesTableCompanion.insert(
              name: Value(game.name),
              targetScore: game.targetScore,
              turnNumber: Value(game.turnNumber),
            ),
          );

      final playerCompanions = game.players
              ?.asMap()
              .entries
              .map(
                (entry) => GamePlayersTableCompanion.insert(
                  gameId: gameId,
                  playerId: Value(entry.value.id),
                  name: Value(entry.value.name),
                  score: Value(game.targetScore),
                  color: Value(entry.value.color),
                  position: entry.key,
                ),
              )
              .toList() ??
          const [];

      if (playerCompanions.isNotEmpty) {
        await database.batch((batch) {
          batch.insertAll(database.gamePlayersTable, playerCompanions);
        });
      }

      return _getGameById(gameId);
    });
  }

  Future<Game?> updateGame(int gameId, int playerId, int newScore, Turn turn, int turnNumber) async {
    return database.transaction(() async {
      final turnId = await database.into(database.turnsTable).insert(
            TurnsTableCompanion.insert(
              gameId: gameId,
              playerId: Value(turn.playerId),
              turnNumber: Value(turnNumber),
            ),
          );

      final throwCompanions = turn.throws
              ?.asMap()
              .entries
              .map(
                (entry) => ThrowsTableCompanion.insert(
                  turnId: turnId,
                  playerId: Value(entry.value.playerId),
                  value: entry.value.value,
                  position: entry.key,
                ),
              )
              .toList() ??
          const [];

      if (throwCompanions.isNotEmpty) {
        await database.batch((batch) {
          batch.insertAll(database.throwsTable, throwCompanions);
        });
      }

      await (database.update(database.gamesTable)
            ..where((table) => table.id.equals(gameId)))
          .write(
        GamesTableCompanion(
          turnNumber: Value(turnNumber),
        ),
      );

      await (database.update(database.gamePlayersTable)
            ..where(
              (table) =>
                  table.gameId.equals(gameId) & table.playerId.equals(playerId),
            ))
          .write(
        GamePlayersTableCompanion(
          score: Value(newScore),
        ),
      );

      return _getGameById(gameId);
    });
  }

  Future<List<Game>> getGames() async {
    final gameRows = await (database.select(database.gamesTable)
          ..orderBy([(table) => OrderingTerm(expression: table.id)]))
        .get();

    return _hydrateGames(gameRows);
  }

  Future<Game?> _getGameById(int gameId) async {
    final gameRow = await (database.select(database.gamesTable)
          ..where((table) => table.id.equals(gameId)))
        .getSingleOrNull();

    if (gameRow == null) {
      return null;
    }

    final games = await _hydrateGames([gameRow]);
    if (games.isEmpty) {
      return null;
    }
    return games.first;
  }

  Future<List<Game>> _hydrateGames(List<GamesTableData> gameRows) async {
    if (gameRows.isEmpty) {
      return [];
    }

    final gameIds = gameRows.map((game) => game.id).toList();
    final gamePlayerRows = await (database.select(database.gamePlayersTable)
          ..where((table) => table.gameId.isIn(gameIds))
          ..orderBy([
            (table) => OrderingTerm(expression: table.gameId),
            (table) => OrderingTerm(expression: table.position),
          ]))
        .get();
    final turnRows = await (database.select(database.turnsTable)
          ..where((table) => table.gameId.isIn(gameIds))
          ..orderBy([
            (table) => OrderingTerm(expression: table.gameId),
            (table) => OrderingTerm(expression: table.id),
          ]))
        .get();

    final turnIds = turnRows.map((turn) => turn.id).toList();
    final throwRows = turnIds.isEmpty
        ? const <ThrowsTableData>[]
        : await (database.select(database.throwsTable)
              ..where((table) => table.turnId.isIn(turnIds))
              ..orderBy([
                (table) => OrderingTerm(expression: table.turnId),
                (table) => OrderingTerm(expression: table.position),
              ]))
            .get();

    final playersByGameId = <int, List<PlayerEmbedded>>{};
    for (final gamePlayerRow in gamePlayerRows) {
      playersByGameId.putIfAbsent(gamePlayerRow.gameId, () => []);
      playersByGameId[gamePlayerRow.gameId]!.add(
        PlayerEmbedded(
          id: gamePlayerRow.playerId,
          name: gamePlayerRow.name,
          score: gamePlayerRow.score,
          color: gamePlayerRow.color,
        ),
      );
    }

    final throwsByTurnId = <int, List<Throw>>{};
    for (final throwRow in throwRows) {
      throwsByTurnId.putIfAbsent(throwRow.turnId, () => []);
      throwsByTurnId[throwRow.turnId]!.add(
        Throw(
          id: throwRow.id,
          playerId: throwRow.playerId,
          value: throwRow.value,
        ),
      );
    }

    final turnsByGameId = <int, List<Turn>>{};
    for (final turnRow in turnRows) {
      turnsByGameId.putIfAbsent(turnRow.gameId, () => []);
      turnsByGameId[turnRow.gameId]!.add(
        Turn(
          id: turnRow.id,
          playerId: turnRow.playerId,
          throws: throwsByTurnId[turnRow.id] ?? const [],
        ),
      );
    }

    return gameRows
        .map(
          (gameRow) => Game(
            id: gameRow.id,
            name: gameRow.name,
            players: playersByGameId[gameRow.id] ?? const [],
            targetScore: gameRow.targetScore,
            turns: turnsByGameId[gameRow.id] ?? const [],
            turnNumber: gameRow.turnNumber,
          ),
        )
        .toList();
  }
}
