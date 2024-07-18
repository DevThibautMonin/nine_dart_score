import 'package:dart_mappable/dart_mappable.dart';

part 'player.mapper.dart';

@MappableClass()
class PlayerEntity with PlayerEntityMappable {
  final int? id;
  final String name;

  PlayerEntity({
    this.id,
    required this.name,
  });
}
