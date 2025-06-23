import 'package:flutter/material.dart';
import 'package:rick_and_morty2/api/api_character.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';

class ListTileModel extends StatelessWidget {
  const ListTileModel({super.key, required this.char});

  final Character char;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              char.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  char.status,
                  style: TextStyle(
                    color: char.status == 'Alive' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  char.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.nameDescriptionEpisodeColorDark
                        : AppColors.nameDescriptionEpisodeColorLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${char.species} • ${char.gender}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.speciesGenderMenuColorDark
                        : AppColors.speciesGenderMenuColorLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
