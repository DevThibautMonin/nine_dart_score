import 'package:nine_dart_score/domain/entities/player/player.dart';

abstract class IPlayerRepository {
  Future createPlayer(PlayerEntity player);
  Future<List<PlayerEntity>> getPlayers();
  Future deletePlayer(int playerId);
}
