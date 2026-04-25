import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/domain/entities/game/game.dart';
import 'package:nine_dart_score/features/game/domain/repositories/game_repository.dart';

@Injectable()
class CreateGameUsecase {
  final IGameRepository gameRepository;

  const CreateGameUsecase({
    required this.gameRepository,
  });

  Future<GameEntity?> call(GameEntity gameEntity) async {
    return await gameRepository.createGame(gameEntity);
  }
}
