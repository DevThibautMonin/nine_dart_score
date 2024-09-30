part of 'game_bloc.dart';

enum GameStatus { initial }

@MappableClass()
class GameState with GameStateMappable {
  final GameStatus gameStatus;
  final GameEntity? game;
  final List<PlayerEntity>? allPlayers;
  final int? targetScore;
  final int currentPlayerIndex;
  final List<ThrowEntity>? throws;
  final int turnNumber;

  // Data validation
  final String gameName;
  final List<PlayerEntity> players;

  const GameState({
    this.gameStatus = GameStatus.initial,
    this.players = const [],
    this.allPlayers,
    this.targetScore,
    this.currentPlayerIndex = 0,
    this.game,
    this.gameName = "",
    this.throws,
    this.turnNumber = 1,
  });

  bool isFormValid() {
    return targetScore != null && gameName.isNotEmpty && players.isNotEmpty;
  }
}
