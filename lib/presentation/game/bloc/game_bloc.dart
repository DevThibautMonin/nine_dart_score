import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/usecases/game/create_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/get_players_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';
part 'game_bloc.mapper.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetPlayersUsecase _getPlayersUsecase = getIt.get();
  final CreateGameUsecase _createGameUsecase = getIt.get();

  GameBloc() : super(const GameState()) {
    on<GetGameData>((event, emit) async {
      final allPlayers = await _getPlayersUsecase();
      emit(state.copyWith(allPlayers: allPlayers));
    });

    on<AddPlayerEvent>((event, emit) {
      List<PlayerEntity>? players = List.from(state.players ?? []);

      players.add(event.player);

      emit(state.copyWith(players: players));
    });

    on<RemovePlayerEvent>((event, emit) {
      List<PlayerEntity>? players = List.from(state.players ?? []);

      players.remove(event.player);

      emit(state.copyWith(players: players));
    });

    on<SelectTargetScore>((event, emit) {
      emit(state.copyWith(targetScore: event.targetScore));
    });

    on<StartGameEvent>((event, emit) async {
      var players = state.players;
      var game = GameEntity(players: players, targetScore: state.targetScore ?? 0);
      var newGame = await _createGameUsecase(game);

      emit(state.copyWith(
        currentPlayerIndex: 0,
        game: newGame,
      ));
    });

    on<NextTurnEvent>((event, emit) async {
      var newIndex = state.currentPlayerIndex + 1;
      final maxIndex = state.players?.length ?? 0;

      if (newIndex >= maxIndex) {
        newIndex = 0;
      }

      emit(state.copyWith(currentPlayerIndex: newIndex));
    });
  }
}
