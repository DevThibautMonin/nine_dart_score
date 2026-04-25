part of 'player_bloc.dart';

enum PlayerStatus { initial, loading, loaded, error }

@MappableClass()
class PlayerState with PlayerStateMappable {
  final List<PlayerEntity>? players;
  final PlayerStatus playerStatus;

  // Data validation
  final String playerName;
  final Color? playerColor;

  const PlayerState({
    this.players,
    this.playerStatus = PlayerStatus.initial,
    this.playerName = "",
    this.playerColor,
  });

  bool isFormValid() {
    return playerName.isNotEmpty && playerColor != null;
  }
}
