import 'package:drift/drift.dart';

import 'package:nine_dart_score/features/game/data/datasources/local/tables/games_table.dart';

class GamePlayersTable extends Table {
  @override
  String get tableName => 'game_players';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get gameId =>
      integer().references(GamesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get playerId => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get score => integer().nullable()();
  IntColumn get color => integer().nullable()();
  IntColumn get position => integer()();
}
