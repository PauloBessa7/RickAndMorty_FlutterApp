import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_event.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_state.dart';
import 'package:rick_and_morty_game/models/character.dart';
import 'package:rick_and_morty_game/repositories/character_repository.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ICharacterRepository repository;
  List<Character> _allCharacters = [];
  int countHumans = 0;
  int countAliens = 0;

  CharacterBloc(this.repository) : super(CharacterInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(CharacterLoading());
      try {
        _allCharacters = await repository.fetchCharacters(); 
        countHumans = _allCharacters.where((character) => character.species == 'Human').length;
        countAliens = _allCharacters.where((character) => character.species == 'Alien').length;
        emit(CharacterLoaded(_allCharacters, _allCharacters, countHumans, countAliens));
      } catch (e) {
        emit(CharacterError('Erro ao carregar personagens'));
      }
    });

    on<FilterCharacters>((event, emit) {
      if (state is CharacterLoaded) {
        final filtered = _allCharacters.where((character) {
          return character.name.toLowerCase().startsWith(event.query.toLowerCase());
        }).toList();

        emit(CharacterLoaded(_allCharacters, filtered, countHumans, countAliens));
      }
    });
  }
}
