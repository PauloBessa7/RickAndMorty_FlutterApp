import '../../../models/character.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> allCharacters;
  final List<Character> filteredCharacters;
  final int countHumans;
  final int countAliens;
  CharacterLoaded(this.allCharacters, this.filteredCharacters, this.countHumans, this.countAliens);
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError(this.message);
}
