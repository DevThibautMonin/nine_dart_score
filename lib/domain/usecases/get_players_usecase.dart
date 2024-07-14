import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';
import 'package:nine_dart_score/domain/entities/player.dart';

class GetPlayersUsecase {
  final PlayerRepository _playerRepository = getIt.get();

  Future<List<PlayerEntity>> call() async {
    return _playerRepository.getPlayers();
  }
}
