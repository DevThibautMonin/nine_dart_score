part of 'game_bloc.dart';

sealed class GameEvent {}

class SelectTargetScore extends GameEvent {
  final int? targetScore;

  SelectTargetScore({
    this.targetScore,
  });
}

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

class StartGameEvent extends GameEvent {
  StartGameEvent();
}

class NextTurnEvent extends GameEvent {
  NextTurnEvent();
}
