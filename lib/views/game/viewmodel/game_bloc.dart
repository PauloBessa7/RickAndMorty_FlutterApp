import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_game/models/character.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_event.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(Character character) : super(GameInitial()) {
    on<GameStartEvent>((event, emit) async {
      emit(GameLoading());

      try {
        final enemy = await fetchRandomEnemyExcluding(event.player.id);
        emit(
          GameLoaded(
            playerDiceRollRound: 0,
            enemyDiceRollRound: 0,
            player: event.player,
            enemy: enemy,
            playerPosition: 0,
            enemyPosition: 0,
          ),
        );
      } catch (e) {
        emit(GameError('Falha ao carregar adversário'));
      }
    });

    on<GameRollDiceEvent>((event, emit) {
      if (state is GameLoaded) {
        final currentState = state as GameLoaded;

        final random = Random();
        final playerRoll = random.nextInt(3) + 1; // 1 a 3
        final enemyRoll = random.nextInt(3) + 1;

        final newPlayerPos = currentState.playerPosition + playerRoll;
        final newEnemyPos = currentState.enemyPosition + enemyRoll;

        // Regra de vitória simples: quem passar de 10 primeiro
        if (newPlayerPos >= 10 && newEnemyPos >= 10) {
          emit(GameWinner("Empate"));
        } else if (newPlayerPos >= 10) {
          emit(GameWinner(currentState.player.name));
        } else if (newEnemyPos >= 10) {
          emit(GameWinner(currentState.enemy.name));
        } else {
          emit(
            GameLoaded(
              enemyDiceRollRound: enemyRoll,
              playerDiceRollRound: playerRoll,
              player: currentState.player,
              enemy: currentState.enemy,
              playerPosition: newPlayerPos,
              enemyPosition: newEnemyPos,
            ),
          );
        }
      }
    });
  }

  Future<Character> fetchRandomEnemyExcluding(int excludedId) async {
    final random = Random();
    int enemyId;
    do {
      enemyId = random.nextInt(826) + 1; // IDs válidos: 1 a 826
    } while (enemyId == excludedId);

    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$enemyId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Character.fromJson(data); // Assumindo que você tem um fromJson
    } else {
      throw Exception('Erro ao buscar inimigo');
    }
  }
}
