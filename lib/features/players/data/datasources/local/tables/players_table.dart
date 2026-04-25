import 'package:drift/drift.dart';

class PlayersTable extends Table {
  @override
  String get tableName => 'players';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get score => integer().nullable()();
  IntColumn get color => integer().nullable()();
}
