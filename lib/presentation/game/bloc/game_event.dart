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

class GameNameChangedEvent extends GameEvent {
  final String? gameName;

  GameNameChangedEvent({
    this.gameName,
  });
}

class StartGameEvent extends GameEvent {
  final String? gameName;

  StartGameEvent({
    this.gameName,
  });
}

class NextPlayerEvent extends GameEvent {
  final PlayerEntity? currentPlayer;
  final int firstThrow;
  final int secondThrow;
  final int thirdThrow;

  NextPlayerEvent({
    this.currentPlayer,
    this.firstThrow = 0,
    this.secondThrow = 0,
    this.thirdThrow = 0,
  });
}

class DeleteGameEvent extends GameEvent {
  final int? gameId;

  DeleteGameEvent({
    this.gameId,
  });
}
