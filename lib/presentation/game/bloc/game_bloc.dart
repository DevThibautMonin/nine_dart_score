import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/player.dart';
import 'package:nine_dart_score/domain/usecases/get_players_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';
part 'game_bloc.mapper.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetPlayersUsecase _getPlayersUsecase = getIt.get();

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
  }
}
