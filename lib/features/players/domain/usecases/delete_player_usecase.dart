import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/players/domain/repositories/player_repository.dart';

@LazySingleton()
class DeletePlayerUsecase {
  final IPlayerRepository playerRepository;

  const DeletePlayerUsecase({
    required this.playerRepository,
  });

  Future call(int playerId) async {
    await playerRepository.deletePlayer(playerId);
  }
}
