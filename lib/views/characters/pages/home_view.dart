import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_bloc.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_event.dart';
import 'package:rick_and_morty_game/views/characters/viewmodel/character_state.dart';
import 'package:rick_and_morty_game/views/characters/widgets/character_detail_widgets.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(FetchCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar personagem',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<CharacterBloc>().add(FilterCharacters(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CharacterLoaded) {
                  final characters = state.filteredCharacters;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 2;
                      if (constraints.maxWidth >= 1200) {
                        crossAxisCount = 6;
                      } else if (constraints.maxWidth >= 900) {
                        crossAxisCount = 4;
                      } else if (constraints.maxWidth >= 600) {
                        crossAxisCount = 3;
                      }

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        padding: const EdgeInsets.all(8),
                        children: characters.map((character) {
                          return Card(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CharacterDetail(
                                          character: character,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: character.id,
                                    child: Image.network(
                                      character.image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    width: double.infinity,
                                    color: Colors.black54,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          character.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Espécie: ${character.species}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                } else if (state is CharacterError) {
                  return Center(child: Text(state.message));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
