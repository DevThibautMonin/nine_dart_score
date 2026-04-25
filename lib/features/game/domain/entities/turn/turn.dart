import 'package:nine_dart_score/features/game/domain/entities/throw/throw.dart';

class TurnEntity {
  final int? id;
  final List<ThrowEntity>? throws;
  final int? playerId;

  TurnEntity({
    this.id,
    this.throws,
    this.playerId,
  });
}
