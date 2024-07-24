import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';

class DeletePlayerUsecase {
  final PlayerRepository _playerRepository = getIt.get();

  Future call(int playerId) async {
    await _playerRepository.deletePlayer(playerId);
  }
}
