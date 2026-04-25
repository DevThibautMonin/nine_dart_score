import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/domain/repositories/game_repository.dart';

@Injectable()
class DeleteGameUsecase {
  final IGameRepository gameRepository;

  const DeleteGameUsecase({
    required this.gameRepository,
  });

  Future<void> call(int gameId) async {
    await gameRepository.deleteGame(gameId);
  }
}
