import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';

@LazySingleton()
class CreatePlayerUsecase {
  final PlayerRepository playerRepository;

  const CreatePlayerUsecase({
    required this.playerRepository,
  });

  Future call(PlayerEntity playerEntity) async {
    await playerRepository.createPlayer(playerEntity);
  }
}
