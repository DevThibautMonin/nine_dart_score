import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

@Injectable()
class GetHistoryGameListUsecase {
  final GameRepository gameRepository;

  const GetHistoryGameListUsecase({
    required this.gameRepository,
  });

  Future<List<GameEntity>?> call() async {
    return await gameRepository.getGames();
  }
}
