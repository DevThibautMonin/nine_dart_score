import 'package:drift/drift.dart';

class GamesTable extends Table {
  @override
  String get tableName => 'games';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get targetScore => integer()();
  IntColumn get turnNumber => integer().nullable()();
}
