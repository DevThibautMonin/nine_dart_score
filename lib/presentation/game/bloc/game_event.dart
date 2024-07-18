part of 'game_bloc.dart';

sealed class GameEvent {}

class AddPlayerEvent extends GameEvent {
  final PlayerEntity player;

  AddPlayerEvent({
    required this.player,
  });
}

class RemovePlayerEvent extends GameEvent {
  final PlayerEntity player;

  RemovePlayerEvent({
    required this.player,
  });
}

class GetGameData extends GameEvent {
  GetGameData();
}
