import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_game/configs/theme_controller.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_factory_model.dart';
import 'views/characters/pages/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          title: 'Rick and Morty App',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: BlocProvider(
            create: (_) => CharacterFactoryViewModel().create(context),
            child: HomeView(),
          ),
        );
      },
    );
  }
}
