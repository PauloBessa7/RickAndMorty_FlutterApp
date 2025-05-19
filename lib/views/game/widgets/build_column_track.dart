import 'package:flutter/material.dart';
import 'package:rick_and_morty_game/models/character.dart';

Widget buildColumnTrack(Character character, int position) {
  return Column(
    children: List.generate(10, (index) {
      bool isHere = index == position;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.black),
        ),
        child:
            isHere
                ? Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.person, size: 40),
                )
                : null,
      );
    }),
  );
}
