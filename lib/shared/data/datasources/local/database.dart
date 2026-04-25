import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/data/datasources/local/tables/game_players_table.dart';
import 'package:nine_dart_score/features/game/data/datasources/local/tables/games_table.dart';
import 'package:nine_dart_score/features/game/data/datasources/local/tables/throws_table.dart';
import 'package:nine_dart_score/features/game/data/datasources/local/tables/turns_table.dart';
import 'package:nine_dart_score/features/players/data/datasources/local/tables/players_table.dart';

part 'database.g.dart';

@LazySingleton()
@DriftDatabase(
  tables: [
    PlayersTable,
    GamesTable,
    GamePlayersTable,
    TurnsTable,
    ThrowsTable,
  ],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'nine_dart_score');
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
