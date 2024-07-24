import 'package:isar/isar.dart';
import 'package:nine_dart_score/data/entities/player/player_embedded.dart';

part 'game.g.dart';

@Collection()
@Name("Game")
class Game {
  Id? id = Isar.autoIncrement;
  List<PlayerEmbedded>? players;
  int targetScore;

  Game({
    required this.targetScore,
    this.players,
  });
}
