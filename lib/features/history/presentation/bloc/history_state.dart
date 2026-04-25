part of 'history_bloc.dart';

enum HistoryStatusEnum {
  initial,
  loading,
  loaded,
  error,
}

@MappableClass()
class HistoryState with HistoryStateMappable {
  final List<GameEntity> games;
  final HistoryStatusEnum historyStatusEnum;

  const HistoryState({
    this.games = const [],
    this.historyStatusEnum = HistoryStatusEnum.initial,
  });
}
