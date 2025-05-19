import 'package:flutter/material.dart';
import 'package:rick_and_morty_game/configs/factory_viewmodel.dart';
import 'package:rick_and_morty_game/core/service/http_service.dart';
import 'package:rick_and_morty_game/repositories/game_repository.dart';
import 'package:rick_and_morty_game/views/game/viewmodel/game_bloc.dart';

final class GameFactoryViewModel implements IFactoryViewModel<GameBloc>{
  @override
  GameBloc create(BuildContext context) {
    final IHttpService service = HttpService();
    final IGameRepository repository = GameRepository(service);
    final GameBloc bloc = GameBloc(repository);
    return bloc;
  }

  @override
  void dispose(BuildContext context, GameBloc viewModel) {
    viewModel.close();
  }

}