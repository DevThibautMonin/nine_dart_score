import 'package:drift/drift.dart';

import 'package:nine_dart_score/features/game/data/datasources/local/tables/games_table.dart';

class TurnsTable extends Table {
  @override
  String get tableName => 'turns';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get gameId =>
      integer().references(GamesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get playerId => integer().nullable()();
  IntColumn get turnNumber => integer().nullable()();
}
