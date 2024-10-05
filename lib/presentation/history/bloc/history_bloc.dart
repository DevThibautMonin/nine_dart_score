import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/usecases/game/delete_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/game/get_history_game_list_usecase.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.mapper.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryGameListUsecase _getHistoryGameListUsecase = getIt.get();
  final DeleteGameUsecase _deleteGameUsecase = getIt.get();

  HistoryBloc() : super(const HistoryState()) {
    on<GetHistoryGameListEvent>((event, emit) async {
      emit(state.copyWith(historyStatusEnum: HistoryStatusEnum.loading));

      var games = await _getHistoryGameListUsecase();

      emit(state.copyWith(
        games: games,
        historyStatusEnum: HistoryStatusEnum.loaded,
      ));
    });

    on<DeleteGameEvent>((event, emit) async {
      emit(state.copyWith(historyStatusEnum: HistoryStatusEnum.loading));
      await _deleteGameUsecase(event.id);
      var games = await _getHistoryGameListUsecase();

      emit(state.copyWith(
        games: games,
        historyStatusEnum: HistoryStatusEnum.loaded,
      ));
    });
  }
}
