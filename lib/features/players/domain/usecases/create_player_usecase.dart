import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/players/domain/entities/player/player.dart';
import 'package:nine_dart_score/features/players/domain/repositories/player_repository.dart';

@LazySingleton()
class CreatePlayerUsecase {
  final IPlayerRepository playerRepository;

  const CreatePlayerUsecase({
    required this.playerRepository,
  });

  Future call(PlayerEntity playerEntity) async {
    await playerRepository.createPlayer(playerEntity);
  }
}
