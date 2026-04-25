part of 'history_bloc.dart';

class HistoryEvent {
  const HistoryEvent();
}

class GetHistoryGameListEvent extends HistoryEvent {
  const GetHistoryGameListEvent();
}

class DeleteGameEvent extends HistoryEvent {
  final int id;

  const DeleteGameEvent({required this.id});
}
