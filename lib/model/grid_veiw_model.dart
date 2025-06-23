import 'package:flutter/material.dart';
import 'package:rick_and_morty2/api/api_character.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';
import 'package:rick_and_morty2/screens/character_detail_screen.dart';

class GridViewModel extends StatelessWidget {
  const GridViewModel({super.key, required this.char});

  final Character char;

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CharacterDetailScreen(char: char, ep: null),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              char.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            char.status,
            style: TextStyle(
              fontSize: 14,
              color: char.status == 'Alive' ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            char.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.nameDescriptionEpisodeColorDark
                  : AppColors.nameDescriptionEpisodeColorLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              '${char.species}, ${char.gender}',
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.speciesGenderMenuColorDark
                    : AppColors.speciesGenderMenuColorLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
