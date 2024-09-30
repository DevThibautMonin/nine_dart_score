import 'package:dart_mappable/dart_mappable.dart';

part 'throw.mapper.dart';

@MappableClass()
class ThrowEntity with ThrowEntityMappable {
  final int? id;
  final int value;
  final int? playerId;

  ThrowEntity({
    this.id,
    this.value = 0,
    this.playerId,
  });
}
