import 'package:rick_and_morty_game/configs/environment_helper.dart';
import 'package:rick_and_morty_game/core/service/http_service.dart';
import '../models/character.dart';

abstract interface class ICharacterRepository {
  Future<List<Character>> fetchCharacters();
}

class CharacterRepository implements ICharacterRepository {

  IHttpService service;

  CharacterRepository(this.service);
  
  final IEnvironmentHelper _environment = EnvironmentHelper();

  @override
  Future<List<Character>> fetchCharacters() async {
    int page = 1;
    final List<Character> allCharacters = [];

    while (page <= 42) {
      try {
        final response = await service.fetchData(
          _environment.urlCharacter,
          page,
        );

        allCharacters.addAll(
          response.results.map((json) => Character.fromJson(json)).toList(),
        );

        page++;
      } catch (e) {
        throw Exception('Erro ao buscar personagens: $e');
      }
    }
    return allCharacters;
  }
}
