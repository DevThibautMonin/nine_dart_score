import 'package:dart_mappable/dart_mappable.dart';
import 'package:nine_dart_score/domain/entities/throw/throw.dart';

part 'turn.mapper.dart';

@MappableClass()
class TurnEntity with TurnEntityMappable {
  final int? id;
  final List<ThrowEntity>? throws;
  final int? playerId;

  TurnEntity({
    this.id,
    this.throws,
    this.playerId,
  });
}
