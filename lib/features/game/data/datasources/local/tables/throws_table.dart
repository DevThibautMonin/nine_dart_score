import 'package:drift/drift.dart';

import 'package:nine_dart_score/features/game/data/datasources/local/tables/turns_table.dart';

class ThrowsTable extends Table {
  @override
  String get tableName => 'throws';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get turnId =>
      integer().references(TurnsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get playerId => integer().nullable()();
  IntColumn get value => integer()();
  IntColumn get position => integer()();
}
