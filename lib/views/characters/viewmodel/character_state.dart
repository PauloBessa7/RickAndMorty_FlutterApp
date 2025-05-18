import '../../../models/character.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> allCharacters;
  final List<Character> filteredCharacters;

  CharacterLoaded(this.allCharacters, this.filteredCharacters);
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError(this.message);
}
