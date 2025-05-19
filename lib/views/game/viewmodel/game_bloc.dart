  import 'dart:math';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:rick_and_morty_game/repositories/game_repository.dart';
  import 'package:rick_and_morty_game/views/game/viewmodel/game_event.dart';
  import 'package:rick_and_morty_game/views/game/viewmodel/game_state.dart';

  class GameBloc extends Bloc<GameEvent, GameState> {
    final IGameRepository repository;
    GameBloc(this.repository) : super(GameInitial()) {
      on<GameStartEvent>((event, emit) async {
        emit(GameLoading());
        try {
          final enemy = await repository.fetchRandomEnemyExcluding(
            event.player.id,
          );
          emit(GameLoaded(player: event.player, enemy: enemy));
        } catch (e) {
          emit(GameError('Falha ao carregar adversário'));
        }
      });

      on<GameRollDiceEvent>((event, emit) {
        if (state is GameLoaded) {
          final currentState = state as GameLoaded;

          final random = Random();
          final playerRoll = random.nextInt(3) + 1;
          final enemyRoll = random.nextInt(3) + 1;

          final newPlayerPos = currentState.playerPosition + playerRoll;
          final newEnemyPos = currentState.enemyPosition + enemyRoll;

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
  }
