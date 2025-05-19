import 'package:flutter/material.dart';
import 'package:rick_and_morty_game/models/character.dart';
import 'package:rick_and_morty_game/views/game/pages/game_view.dart';

class CharacterDetail extends StatelessWidget {
  final Character character;

  const CharacterDetail({super.key, required this.character});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "alive":
        return Colors.green;
      case "dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case "male":
        return Icons.male;
      case "female":
        return Icons.female_outlined;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GameView(character: character),
            ),
          );
        },
        child: Text('Jogar'),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Hero(
            tag: character.id,
            child: Container(
              margin: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: NetworkImage(character.image),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  _buildInfoCard(
                    icon: Icons.favorite,
                    label: "Status",
                    value: character.status,
                    iconColor: getStatusColor(character.status),
                  ),
                  _buildInfoCard(
                    icon: Icons.pets,
                    label: "Espécie",
                    value: character.species,
                  ),
                  if (character.type.isNotEmpty)
                    _buildInfoCard(
                      icon: Icons.category,
                      label: "Tipo",
                      value: character.type,
                    ),
                  _buildInfoCard(
                    icon: getGenderIcon(character.gender),
                    label: "Gênero",
                    value: character.gender,
                  ),
                  _buildInfoCard(
                    icon: Icons.fingerprint,
                    label: "ID",
                    value: character.id.toString(),
                  ),
                  _buildInfoCard(
                    icon: Icons.link,
                    label: "URL",
                    value: character.url,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    Color iconColor = Colors.blueGrey,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF9F9F9),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
