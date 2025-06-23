import 'package:flutter/material.dart';
import 'package:rick_and_morty2/api/api_episode.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';

class EpisodeTileModel extends StatelessWidget {
  final Result ep;
  const EpisodeTileModel({super.key, required this.ep});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {},
      child: Container(
        // width: 240,
        // margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/episode_poster_.png',
                width: 74,
                height: 74,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ep.episode,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF22A2BD),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ep.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? AppColors.nameDescriptionEpisodeColorDark
                          : AppColors.nameDescriptionEpisodeColorLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ep.airDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6E798C),
                    ),
                  ),
                ],
              ),
            ),
            ImageIcon(
              AssetImage('assets/icons/vector_.png'),
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
