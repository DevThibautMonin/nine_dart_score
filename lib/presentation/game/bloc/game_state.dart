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
  final bool hasGameEnded;
  final PlayerEntity? winner;
  final int? firstScore;
  final int? secondScore;
  final int? thirdScore;

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
    this.hasGameEnded = false,
    this.winner,
    this.firstScore,
    this.secondScore,
    this.thirdScore,
  });

  bool isFormValid() {
    return targetScore != null && gameName.isNotEmpty && players.isNotEmpty;
  }
}
