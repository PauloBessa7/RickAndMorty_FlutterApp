import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_game/core/service/http_service.dart';
import 'package:rick_and_morty_game/models/character.dart';
import 'package:rick_and_morty_game/repositories/character_repository.dart';
import 'package:rick_and_morty_game/repositories/game_repository.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_bloc.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_event.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_factory_model.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_state.dart';
import 'package:rick_and_morty_game/views/game/widgets/build_column_track.dart';

class GameView extends StatelessWidget {
  final Character character;
  const GameView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GameFactoryViewModel().create(context)
                ..add(GameStartEvent(character)),
      child: const GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _showWinnerDialog(BuildContext context, String winnerName) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('🏁 Resultado'),
            content: Text(winnerName),
            actions: [
              TextButton(
                onPressed: () {
                  // Fecha o AlertDialog
                  Navigator.pop(context);
                  // Volta para a tela anterior (sai do jogo)
                  Navigator.pop(context);
                },
                child: const Text('Sair'),
              ),
            ],
          ),
    );
  }

  void _showDiceRollDialog(
    BuildContext context,
    int enemyRoll,
    int playerRoll,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('🎲 Rolagem de Dados'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Você rolou:'),
                Image.asset('assets/dice$playerRoll.png', height: 50),
                const SizedBox(height: 16),
                const Text('Inimigo rolou:'),
                Image.asset('assets/dice$enemyRoll.png', height: 50),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corrida Interdimensional')),
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameWinner) {
            _showWinnerDialog(context, state.name);
          }
        },
        builder: (context, state) {
          if (state is GameLoading || state is GameInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GameLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.enemyDiceRollRound != 0) {
                _showDiceRollDialog(
                  context,
                  state.enemyDiceRollRound,
                  state.playerDiceRollRound,
                );
              }
            });

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${state.player.name} vs ${state.enemy.name}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildColumnTrack(state.player, state.playerPosition),
                        buildColumnTrack(state.enemy, state.enemyPosition),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Erro ao carregar jogo.'));
          }
        },
      ),
      floatingActionButton: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            return FloatingActionButton.extended(
              onPressed: () {
                context.read<GameBloc>().add(GameRollDiceEvent());
              },
              label: const Text('🎲 Jogar dado'),
              icon: const Icon(Icons.casino),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
