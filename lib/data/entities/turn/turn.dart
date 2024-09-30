import 'package:isar/isar.dart';
import 'package:nine_dart_score/data/entities/throw/throw.dart';

part 'turn.g.dart';

@Embedded()
class Turn {
  final int? id;
  final List<Throw>? throws;
  final int? playerId;

  Turn({
    this.id,
    this.throws,
    this.playerId,
  });
}
