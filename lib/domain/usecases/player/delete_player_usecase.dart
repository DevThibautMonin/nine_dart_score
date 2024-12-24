import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';

@LazySingleton()
class DeletePlayerUsecase {
  final PlayerRepository playerRepository;

  const DeletePlayerUsecase({
    required this.playerRepository,
  });

  Future call(int playerId) async {
    await playerRepository.deletePlayer(playerId);
  }
}
