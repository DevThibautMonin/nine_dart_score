import 'package:isar/isar.dart';

part 'player.g.dart';

@Collection()
@Name("Player")
class Player {
  Id? id = Isar.autoIncrement;
  String? name;
  int? score;

  Player({
    this.id,
    this.name,
    this.score,
  });
}
