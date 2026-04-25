import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/features/game/domain/entities/game/game.dart';
import 'package:nine_dart_score/features/game/domain/repositories/game_repository.dart';

@Injectable()
class GetHistoryGameListUsecase {
  final IGameRepository gameRepository;

  const GetHistoryGameListUsecase({
    required this.gameRepository,
  });

  Future<List<GameEntity>?> call() async {
    return await gameRepository.getGames();
  }
}
