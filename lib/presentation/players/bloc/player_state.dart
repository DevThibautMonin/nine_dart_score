part of 'player_bloc.dart';

enum PlayerStatus { initial, loading, loaded, error }

@MappableClass()
class PlayerState with PlayerStateMappable {
  final List<PlayerEntity>? players;
  final PlayerStatus playerStatus;

  const PlayerState({
    this.players,
    this.playerStatus = PlayerStatus.initial,
  });
}
