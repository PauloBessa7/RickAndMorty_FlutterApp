import 'dart:math';

import 'package:rick_and_morty_game/configs/environment_helper.dart';
import 'package:rick_and_morty_game/core/service/http_service.dart';
import 'package:rick_and_morty_game/models/character.dart';

abstract interface class IGameRepository {
  Future<Character> fetchCharacter(int id);
  Future<Character> fetchRandomEnemyExcluding(int excludedId);
}

class GameRepository implements IGameRepository {
  IHttpService service;

  GameRepository(this.service);

  final IEnvironmentHelper _environment = EnvironmentHelper();

  @override
  Future<Character> fetchRandomEnemyExcluding(int excludedId) async {
    final random = Random();
    int enemyId;
    do {
      enemyId = random.nextInt(826) + 1;
    } while (enemyId == excludedId);

    final response = fetchCharacter(enemyId);

    return response;
  }

  @override
  Future<Character> fetchCharacter(int id) async {
    final response = await service.fetchDataWithId(_environment.urlCharacter, id);
    final Character character = response;
    return character;
  }
}
