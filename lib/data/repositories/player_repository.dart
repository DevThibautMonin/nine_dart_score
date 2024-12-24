import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/datasources/local/player_local_datasource.dart';
import 'package:nine_dart_score/data/mappers/player_mapper.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/repositories/player_repository.dart';

@LazySingleton()
class PlayerRepository implements IPlayerRepository {
  final PlayerLocalDatasource playerLocalDatasource;

  const PlayerRepository({
    required this.playerLocalDatasource,
  });

  @override
  Future createPlayer(PlayerEntity playerEntity) async {
    final playerData = PlayerMapper.toData(playerEntity);

    await playerLocalDatasource.createPlayer(playerData);
  }

  @override
  Future<List<PlayerEntity>> getPlayers() async {
    final players = await playerLocalDatasource.getPlayers();
    return players.map((player) => PlayerMapper.toEntityFromData(player)).toList();
  }

  @override
  Future deletePlayer(int playerId) async {
    await playerLocalDatasource.deletePlayer(playerId);
  }
}
