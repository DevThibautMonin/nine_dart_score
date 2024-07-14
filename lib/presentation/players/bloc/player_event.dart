part of 'player_bloc.dart';

class PlayerEvent {}

class GetPlayersEvent extends PlayerEvent {}

class DeletePlayerEvent extends PlayerEvent {
  final int playerId;

  DeletePlayerEvent({
    required this.playerId,
  });
}
