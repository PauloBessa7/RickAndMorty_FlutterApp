import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_bloc.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_event.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_state.dart';
import 'package:rick_and_morty_game/models/character.dart';
import 'package:rick_and_morty_game/repositories/character_repository.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() { // Refazer tudo antes de entregar
// + Mockar todas as propriedades do Character
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
  });

  final fakeCharacters = [
    Character(
      id: 0,
      name: '',
      status: '',
      species: '',
      type: '',
      gender: '',
      image: '',
      url: '',
    ),
    Character(
      id: 11,
      name: '',
      status: '',
      species: '',
      type: '',
      gender: '',
      image: '',
      url: '',
    ),
  ];

  blocTest<CharacterBloc, CharacterState>(
    'deve emitir [Loading, Loaded] quando fetchCharacters for disparado',
    build: () {
      when(
        () => mockRepository.fetchCharacters(),
      ).thenAnswer((_) async => fakeCharacters);
      return CharacterBloc(mockRepository);
    },
    act: (bloc) => bloc.add(FetchCharacters()),
    expect:
        () => [
          isA<CharacterLoading>(),
          isA<CharacterLoaded>().having(
            (s) => s.allCharacters.length,
            'quantidade',
            2,
          ),
        ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'deve filtrar personagens com SearchCharacters',
    build: () {
      return CharacterBloc(mockRepository);
    },
    seed: () => CharacterLoaded(fakeCharacters, fakeCharacters, 0, 0),
    act: (bloc) => bloc.add(FilterCharacters('rick')),
    expect:
        () => [
          isA<CharacterLoaded>().having(
            (s) => s.allCharacters.map((e) => e.name).toList(),
            'nomes',
            ['Rick'],
          ),
        ],
  );
}
