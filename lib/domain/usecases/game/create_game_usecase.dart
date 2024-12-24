import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

@Injectable()
class CreateGameUsecase {
  final GameRepository gameRepository;

  const CreateGameUsecase({
    required this.gameRepository,
  });

  Future<GameEntity?> call(GameEntity gameEntity) async {
    return await gameRepository.createGame(gameEntity);
  }
}
