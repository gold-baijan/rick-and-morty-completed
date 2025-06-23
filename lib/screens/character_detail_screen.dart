import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

import 'package:rick_and_morty2/api/api_character.dart';
import 'package:rick_and_morty2/api/api_episode.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';
import 'package:rick_and_morty2/model/episode_tile_model.dart';
import 'package:rick_and_morty2/model/fav_character.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character char;

  const CharacterDetailScreen({super.key, required this.char, required ep});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  List<Result> episodes = [];
  bool loading = true;
  late Box<FavCharacter> favoritesBox;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadEpisodes();
    favoritesBox = Hive.box<FavCharacter>('favorites');
    isFavorite = favoritesBox.values.any((c) => c.id == widget.char.id);
  }

  Future<void> _loadEpisodes() async {
    final urls = widget.char.episode;
    final responses = await Future.wait(
      urls.map((e) => http.get(Uri.parse(e))),
    );
    final results = responses
        .where((r) => r.statusCode == 200)
        .map((r) => Result.fromJson(json.decode(r.body)))
        .toList();
    setState(() {
      episodes = results;
      loading = false;
    });
  }

  void _toggleFavorite() {
    final exists = favoritesBox.values.any((c) => c.id == widget.char.id);
    if (exists) {
      final key = favoritesBox.keys.firstWhere(
        (k) => favoritesBox.get(k)?.id == widget.char.id,
      );
      favoritesBox.delete(key);
    } else {
      favoritesBox.add(
        FavCharacter(
          id: widget.char.id,
          name: widget.char.name,
          image: widget.char.image,
        ),
      );
    }
    setState(() => isFavorite = !exists);
  }

  @override
  Widget build(BuildContext context) {
    final char = widget.char;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 218,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final appBarHeight = constraints.biggest.height;
                final isCollapsed =
                    appBarHeight <=
                    kToolbarHeight + MediaQuery.of(context).padding.top + 12;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(widget.char.image, fit: BoxFit.cover),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(219, 0, 0, 0),
                            Color.fromARGB(108, 43, 43, 43),
                            Color.fromARGB(108, 43, 43, 43),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    if (isCollapsed)
                      Positioned(
                        left: 72,
                        bottom: 12,
                        child: Text(
                          char.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  
                  const SizedBox(height: 16),
                  
                  CircleAvatar(
                    radius: 68,
                    backgroundColor: char.status == 'Alive'
                        ? Colors.green
                        : Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        char.image,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    char.name,
                    style: TextStyle(fontSize: 34,
                      color: isDark
                          ? AppColors.nameDescriptionEpisodeColorDark
                          : AppColors.nameDescriptionEpisodeColorLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    char.status,
                    style: TextStyle(
                      color: char.status == 'Alive' ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'The main protagonist of the animated series Rick and Morty...',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.nameDescriptionEpisodeColorDark
                          : AppColors.nameDescriptionEpisodeColorLight,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'sex',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.speciesGenderDetailColorDark
                                  : AppColors.speciesGenderDetailColorLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            char.gender,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.nameDescriptionEpisodeColorDark
                                  : AppColors.nameDescriptionEpisodeColorLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 120),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'race',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.speciesGenderDetailColorDark
                                  : AppColors.speciesGenderDetailColorLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            char.species,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.nameDescriptionEpisodeColorDark
                                  : AppColors.nameDescriptionEpisodeColorLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'place of birth',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.speciesGenderDetailColorDark
                              : AppColors.speciesGenderDetailColorLight,
                        ),
                      ),
                      Text(
                        char.origin.name,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.nameDescriptionEpisodeColorDark
                              : AppColors.nameDescriptionEpisodeColorLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'location',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.speciesGenderDetailColorDark
                              : AppColors.speciesGenderDetailColorLight,
                        ),
                      ),
                      Text(
                        char.location.name,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.nameDescriptionEpisodeColorDark
                              : AppColors.nameDescriptionEpisodeColorLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Divider(color: isDark ? AppColors.divider : Colors.grey),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EPISODES',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.nameDescriptionEpisodeColorDark
                              : AppColors.nameDescriptionEpisodeColorLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'All episodes',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.speciesGenderDetailColorDark
                              : AppColors.speciesGenderDetailColorLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (loading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        return EpisodeTileModel(ep: episodes[index]);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
