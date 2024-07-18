part of 'game_bloc.dart';

sealed class GameEvent {}

class SelectTargetScore extends GameEvent {
  final String? targetScore;

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
