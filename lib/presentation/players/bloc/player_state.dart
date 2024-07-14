part of 'player_bloc.dart';

enum PlayerStatus { initial, loading, loaded, error }

@MappableClass()
class PlayerState with PlayerStateMappable {
  final List<PlayerEntity>? players;
  final PlayerStatus playerStatus;

  // Data validation
  final String playerName;

  const PlayerState({
    this.players,
    this.playerStatus = PlayerStatus.initial,
    this.playerName = "",
  });

  bool isFormValid() {
    return playerName.isNotEmpty;
  }
}
