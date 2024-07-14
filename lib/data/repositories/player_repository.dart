import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/datasources/local/player_local_datasource.dart';
import 'package:nine_dart_score/data/entities/player.dart';
import 'package:nine_dart_score/domain/entities/player.dart';
import 'package:nine_dart_score/domain/repositories/player_repository.dart';

class PlayerRepository implements IPlayerRepository {
  final PlayerLocalDatasource _playerLocalDatasource = getIt.get();

  @override
  Future createPlayer(PlayerEntity playerEntity) async {
    final player = Player(
      id: playerEntity.id,
      name: playerEntity.name,
    );

    await _playerLocalDatasource.createPlayer(player);
  }

  @override
  Future<List<PlayerEntity>> getPlayers() async {
    final players = await _playerLocalDatasource.getPlayers();
    return players.map((e) {
      return PlayerEntity(id: e.id, name: e.name);
    }).toList();
  }

  @override
  Future deletePlayer(int playerId) async {
    await _playerLocalDatasource.deletePlayer(playerId);
  }
}
