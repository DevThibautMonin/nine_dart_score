import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/entities/throw/throw.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';
import 'package:nine_dart_score/domain/enums/classic_game_enum.dart';
import 'package:nine_dart_score/domain/usecases/game/create_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/game/delete_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/get_players_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';
part 'game_bloc.mapper.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetPlayersUsecase _getPlayersUsecase = getIt.get();
  final CreateGameUsecase _createGameUsecase = getIt.get();
  final GameRepository _gameRepository = getIt.get();
  final DeleteGameUsecase _deleteGameUsecase = getIt.get();

  GameBloc() : super(const GameState()) {
    on<GetGameData>((event, emit) async {
      final allPlayers = await _getPlayersUsecase();
      emit(state.copyWith(allPlayers: allPlayers));
    });

    on<AddPlayerEvent>((event, emit) {
      List<PlayerEntity>? players = List.from(state.players);

      players.add(event.player);

      emit(state.copyWith(players: players));
    });

    on<RemovePlayerEvent>((event, emit) {
      List<PlayerEntity>? players = List.from(state.players);

      players.remove(event.player);

      emit(state.copyWith(players: players));
    });

    on<SelectTargetScore>((event, emit) {
      emit(state.copyWith(targetScore: event.targetScore));
    });

    on<StartGameEvent>((event, emit) async {
      var players = state.players;
      var game = GameEntity(players: players, targetScore: state.targetScore.score, name: event.gameName, turns: []);
      var newGame = await _createGameUsecase(game);

      emit(state.copyWith(
        currentPlayerIndex: 0,
        game: newGame,
      ));
    });

    on<GameNameChangedEvent>((event, emit) {
      emit(state.copyWith(gameName: event.gameName));
    });

    on<NextPlayerEvent>((event, emit) async {
      var currentPlayer = state.game?.players?[state.currentPlayerIndex];
      var currentPlayerScore = state.game?.players?[state.currentPlayerIndex].score;
      var turnNumber = state.turnNumber;

      var firstThrow = ThrowEntity(playerId: currentPlayer?.id, value: event.firstThrow);
      var secondThrow = ThrowEntity(playerId: currentPlayer?.id, value: event.secondThrow);
      var thirdThrow = ThrowEntity(playerId: currentPlayer?.id, value: event.thirdThrow);
      var turn = TurnEntity(throws: [firstThrow, secondThrow, thirdThrow], playerId: currentPlayer?.id);

      var totalScore = firstThrow.value + secondThrow.value + thirdThrow.value;
      var currentPlayerNewScore = 0;

      if (currentPlayerScore != null) {
        currentPlayerNewScore = currentPlayerScore - totalScore;
      }

      var result = await _gameRepository.updateGame(
        state.game?.id ?? 0,
        currentPlayer?.id ?? 0,
        currentPlayerNewScore,
        turn,
        state.turnNumber,
      );

      if (currentPlayerNewScore <= 0) {
        emit(state.copyWith(
          hasGameEnded: true,
          winner: currentPlayer,
        ));
      } else {
        var newIndex = state.currentPlayerIndex + 1;
        final maxIndex = state.players.length;

        if (newIndex >= maxIndex) {
          newIndex = 0;
          var newTurnNumber = turnNumber + 1;
          emit(state.copyWith(turnNumber: newTurnNumber));
        }

        emit(state.copyWith(
          currentPlayerIndex: newIndex,
          game: result,
          hasGameEnded: false,
          firstScore: null,
          secondScore: null,
          thirdScore: null,
        ));
      }
    });

    on<DeleteGameEvent>((event, emit) async {
      await _deleteGameUsecase(event.gameId ?? 0);
    });

    on<UpdateFirstScore>((event, emit) {
      emit(state.copyWith(firstScore: event.score));
    });

    on<UpdateSecondScore>((event, emit) {
      emit(state.copyWith(secondScore: event.score));
    });

    on<UpdateThirdScore>((event, emit) {
      emit(state.copyWith(thirdScore: event.score));
    });
  }
}
