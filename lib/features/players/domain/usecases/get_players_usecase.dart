import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/players/domain/entities/player/player.dart';
import 'package:nine_dart_score/features/players/domain/repositories/player_repository.dart';

@LazySingleton()
class GetPlayersUsecase {
  final IPlayerRepository playerRepository;

  const GetPlayersUsecase({
    required this.playerRepository,
  });

  Future<List<PlayerEntity>> call() async {
    return playerRepository.getPlayers();
  }
}
