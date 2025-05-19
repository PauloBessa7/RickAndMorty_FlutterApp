import 'package:flutter/material.dart';
import 'package:rick_and_morty_game/configs/factory_viewmodel.dart';
import 'package:rick_and_morty_game/core/service/http_service.dart';
import 'package:rick_and_morty_game/repositories/character_repository.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_bloc.dart';

final class CharacterFactoryViewModel implements IFactoryViewModel<CharacterBloc>{
  @override
  CharacterBloc create(BuildContext context) {
    final IHttpService service = HttpService();
    final ICharacterRepository repository = CharacterRepository(service);
    final CharacterBloc bloc = CharacterBloc(repository);
    return bloc;
  }

  @override
  void dispose(BuildContext context, CharacterBloc viewModel) {
    viewModel.close();
  }
}