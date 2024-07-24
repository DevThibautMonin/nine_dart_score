import 'package:dart_mappable/dart_mappable.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/entities/throw/throw.dart';

part 'turn.mapper.dart';

@MappableClass()
class TurnEntity with TurnEntityMappable {
  final int? id;
  final PlayerEntity? player;
  final List<ThrowEntity>? throws;

  TurnEntity({
    this.id,
    this.player,
    this.throws,
  });
}
