part of 'game_bloc.dart';

enum GameStatus { initial }

@MappableClass()
class GameState with GameStateMappable {
  final GameStatus gameStatus;
  final List<PlayerEntity>? players;
  final List<PlayerEntity>? allPlayers;

  const GameState({
    this.gameStatus = GameStatus.initial,
    this.players,
    this.allPlayers,
  });
}