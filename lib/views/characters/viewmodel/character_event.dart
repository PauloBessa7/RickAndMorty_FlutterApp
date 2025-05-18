abstract class CharacterEvent {}

class FetchCharacters extends CharacterEvent {}

class FilterCharacters extends CharacterEvent {
  final String query;

  FilterCharacters(this.query);
}