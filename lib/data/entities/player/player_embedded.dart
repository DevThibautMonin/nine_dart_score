import 'package:isar/isar.dart';

part 'player_embedded.g.dart';

@Embedded()
@Name("PlayerEmbedded")
class PlayerEmbedded {
  int? id;
  String? name;
  int? score;

  PlayerEmbedded({
    this.id,
    this.name,
    this.score,
  });
}
