import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';

class DeleteGameUsecase {
  final GameRepository _gameRepository = getIt.get();

  Future<void> call(int gameId) async {
    await _gameRepository.deleteGame(gameId);
  }
}
