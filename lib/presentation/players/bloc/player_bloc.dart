import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/domain/usecases/player/create_player_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/delete_player_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/get_players_usecase.dart';

part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.mapper.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayersUsecase _getPlayersUsecase = getIt.get();
  final DeletePlayerUsecase _deletePlayerUsecase = getIt.get();
  final CreatePlayerUsecase _createPlayerUsecase = getIt.get();

  PlayerBloc() : super(const PlayerState()) {
    on<CreatePlayerEvent>((event, emit) async {
      emit(state.copyWith(playerStatus: PlayerStatus.loading));

      final player = event.playerEntity;

      await _createPlayerUsecase(player);
      final players = await _getPlayersUsecase();

      emit(state.copyWith(
        playerStatus: PlayerStatus.loaded,
        players: players,
        playerName: "",
      ));
    });

    on<GetPlayersEvent>((event, emit) async {
      emit(state.copyWith(playerStatus: PlayerStatus.loading));

      final players = await _getPlayersUsecase();

      emit(state.copyWith(
        players: players,
        playerStatus: PlayerStatus.loaded,
      ));
    });

    on<DeletePlayerEvent>((event, emit) async {
      emit(state.copyWith(playerStatus: PlayerStatus.loading));

      await _deletePlayerUsecase(event.playerId);
      final players = await _getPlayersUsecase();

      emit(state.copyWith(
        playerStatus: PlayerStatus.loaded,
        players: players,
      ));
    });

    on<PlayerNameChanged>((event, emit) {
      emit(state.copyWith(playerName: event.playerName));
    });

    on<PlayerColorChanged>((event, emit) {
      emit(state.copyWith(playerColor: event.playerColor));
    });
  }
}
