import 'package:nine_dart_score/features/game/data/entities/throw/throw.dart';
class Turn {
  final int? id;
  final List<Throw>? throws;
  final int? playerId;

  const Turn({
    this.id,
    this.throws,
    this.playerId,
  });
}
