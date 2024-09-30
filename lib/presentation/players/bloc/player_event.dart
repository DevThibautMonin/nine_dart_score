part of 'player_bloc.dart';

class PlayerEvent {}

class GetPlayersEvent extends PlayerEvent {}

class DeletePlayerEvent extends PlayerEvent {
  final int playerId;

  DeletePlayerEvent({
    required this.playerId,
  });
}

class CreatePlayerEvent extends PlayerEvent {
  final PlayerEntity playerEntity;

  CreatePlayerEvent({
    required this.playerEntity,
  });
}

class PlayerNameChanged extends PlayerEvent {
  final String? playerName;

  PlayerNameChanged({
    this.playerName,
  });
}

class PlayerColorChanged extends PlayerEvent {
  final Color? playerColor;

  PlayerColorChanged({
    this.playerColor,
  });
}
