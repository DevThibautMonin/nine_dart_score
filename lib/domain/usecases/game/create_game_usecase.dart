import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';

class CreateGameUsecase {
  final GameRepository _gameRepository = getIt.get();

  Future<GameEntity?> call(GameEntity gameEntity) async {
    return await _gameRepository.createGame(gameEntity);
  }
}
