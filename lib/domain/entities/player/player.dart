import 'package:dart_mappable/dart_mappable.dart';

part 'player.mapper.dart';

@MappableClass()
class PlayerEntity with PlayerEntityMappable {
  final int? id;
  final String? name;
  final int? score;

  PlayerEntity({
    this.id,
    this.name,
    this.score,
  });
}
