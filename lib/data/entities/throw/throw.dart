import 'package:isar/isar.dart';

part 'throw.g.dart';

@Embedded()
class Throw {
  final int? id;
  final int value;
  final int? playerId;

  Throw({
    this.id,
    this.value = 0,
    this.playerId,
  });
}
