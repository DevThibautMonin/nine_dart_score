import 'package:isar/isar.dart';

part 'player.g.dart';

@Collection()
@Name("Player")
class Player {
  Id? id = Isar.autoIncrement;

  String name;

  Player({
    this.id,
    required this.name,
  });
}
