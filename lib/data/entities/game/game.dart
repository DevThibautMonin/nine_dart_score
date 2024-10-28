import 'package:isar/isar.dart';
import 'package:nine_dart_score/data/entities/player/player_embedded.dart';
import 'package:nine_dart_score/data/entities/throw/throw.dart';
import 'package:nine_dart_score/data/entities/turn/turn.dart';

part 'game.g.dart';

@Collection()
@Name("Game")
class Game {
  Id? id = Isar.autoIncrement;
  String? name;
  List<PlayerEmbedded>? players;
  int targetScore;
  List<Turn>? turns;
  int? turnNumber;

  Game({
    this.id,
    this.name,
    this.players,
    required this.targetScore,
    this.turns,
    this.turnNumber,
  });
}
