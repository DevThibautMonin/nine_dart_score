import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/domain/entities/game/game.dart';
import 'package:nine_dart_score/features/game/domain/entities/turn/turn.dart';
import 'package:nine_dart_score/features/game/domain/repositories/game_repository.dart';

@Injectable()
class UpdateGameUsecase {
  final IGameRepository gameRepository;

  const UpdateGameUsecase({
    required this.gameRepository,
  });

  Future<GameEntity?> call(
    int gameId,
    int playerId,
    int newScore,
    TurnEntity turn,
    int turnNumber,
  ) async {
    return await gameRepository.updateGame(
      gameId,
      playerId,
      newScore,
      turn,
      turnNumber,
    );
  }
}
