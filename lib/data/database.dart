import 'package:isar/isar.dart';
import 'package:nine_dart_score/data/entities/player.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  late Future<Isar> database;

  Database() {
    database = openDatabase();
  }

  Future<Isar> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PlayerSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
