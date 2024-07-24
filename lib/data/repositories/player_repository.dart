import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/datasources/local/player_local_datasource.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/repositories/player_repository.dart';

class PlayerRepository implements IPlayerRepository {
  final PlayerLocalDatasource _playerLocalDatasource = getIt.get();

  @override
  Future createPlayer(PlayerEntity playerEntity) async {
    final playerData = PlayerMapper.toData(playerEntity);

    await _playerLocalDatasource.createPlayer(playerData);
  }

  @override
  Future<List<PlayerEntity>> getPlayers() async {
    final players = await _playerLocalDatasource.getPlayers();
    return players.map((player) => PlayerMapper.toEntityFromData(player)).toList();
  }

  @override
  Future deletePlayer(int playerId) async {
    await _playerLocalDatasource.deletePlayer(playerId);
  }
}
