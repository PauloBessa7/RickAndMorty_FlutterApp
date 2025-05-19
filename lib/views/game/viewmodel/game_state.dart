import 'package:rick_and_morty_game/models/character.dart';

abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final Character player;
  final Character enemy;
  final int playerPosition;
  final int enemyPosition;
  final int playerDiceRollRound;
  final int enemyDiceRollRound;

  GameLoaded({
    this.playerDiceRollRound = 0,
    this.enemyDiceRollRound = 0,
    required this.player,
    required this.enemy,
    this.playerPosition = 0,
    this.enemyPosition = 0,
  });
}

class GameWinner extends GameState {
  final String name;
  GameWinner(this.name);
}

class GameError extends GameState {
  final String message;

  GameError(this.message);
}
