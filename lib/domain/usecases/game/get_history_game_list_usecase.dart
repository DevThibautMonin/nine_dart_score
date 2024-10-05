import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

class GetHistoryGameListUsecase {
  final GameRepository _gameRepository = getIt.get();

  Future<List<GameEntity>?> call() async {
    return await _gameRepository.getGames();
  }
}
