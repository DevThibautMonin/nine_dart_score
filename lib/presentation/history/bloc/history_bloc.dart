import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/domain/entities/game/game.dart';
import 'package:nine_dart_score/domain/usecases/game/delete_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/game/get_history_game_list_usecase.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.mapper.dart';

@Injectable()
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryGameListUsecase getHistoryGameListUsecase;
  final DeleteGameUsecase deleteGameUsecase;

  HistoryBloc({
    required this.deleteGameUsecase,
    required this.getHistoryGameListUsecase,
  }) : super(const HistoryState()) {
    on<GetHistoryGameListEvent>((event, emit) async {
      emit(state.copyWith(historyStatusEnum: HistoryStatusEnum.loading));

      var games = await getHistoryGameListUsecase();

      emit(state.copyWith(
        games: games,
        historyStatusEnum: HistoryStatusEnum.loaded,
      ));
    });

    on<DeleteGameEvent>((event, emit) async {
      emit(state.copyWith(historyStatusEnum: HistoryStatusEnum.loading));
      await deleteGameUsecase(event.id);
      var games = await getHistoryGameListUsecase();

      emit(state.copyWith(
        games: games,
        historyStatusEnum: HistoryStatusEnum.loaded,
      ));
    });
  }
}
