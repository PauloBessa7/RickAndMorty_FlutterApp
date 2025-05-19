import 'package:rick_and_morty_game/models/character.dart';

abstract class GameEvent {}

class GameStartEvent extends GameEvent {
  final Character player;
  GameStartEvent(this.player);
}

class GameRollDiceEvent extends GameEvent {}
