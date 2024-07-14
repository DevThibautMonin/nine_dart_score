import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';
import 'package:nine_dart_score/domain/entities/player.dart';

class CreatePlayerUsecase {
  final PlayerRepository _playerRepository = getIt.get();

  Future call(PlayerEntity playerEntity) async {
    await _playerRepository.createPlayer(playerEntity);
  }
}
