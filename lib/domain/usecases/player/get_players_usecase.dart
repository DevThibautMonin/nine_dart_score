import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';

@LazySingleton()
class GetPlayersUsecase {
  final PlayerRepository playerRepository;

  const GetPlayersUsecase({
    required this.playerRepository,
  });

  Future<List<PlayerEntity>> call() async {
    return playerRepository.getPlayers();
  }
}
