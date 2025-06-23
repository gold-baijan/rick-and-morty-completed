import 'package:flutter/material.dart';
import 'package:rick_and_morty2/api/api_character.dart';
import 'package:rick_and_morty2/model/grid_veiw_model.dart';
import 'package:rick_and_morty2/model/list_tile_model.dart';
import 'package:rick_and_morty2/screens/character_detail_screen.dart';

class CharactersBody extends StatelessWidget {
  final List<Character> displayed;
  final bool isGrid;
  final bool isLoading;
  final ScrollController controller;
  final void Function() toggleView;

  const CharactersBody({
    super.key,
    required this.displayed,
    required this.isGrid,
    required this.isLoading,
    required this.controller,
    required this.toggleView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔎 Поиск + Переключатель
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ВСЕГО ПЕРСОНАЖЕЙ: 200',
                style: TextStyle(fontSize: 12, color: Color(0xFF5B6975)),
              ),
              IconButton(
                icon: Icon(
                  isGrid ? Icons.view_list : Icons.grid_view,
                  color: const Color(0xAA5B6975),
                ),
                onPressed: toggleView,
              ),
            ],
          ),
        ),

        // 📋 Список или Сетка
        isGrid
            ? Expanded(
                child: GridView.builder(
                  controller: controller,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 164 / 192,
                  ),
                  itemCount: displayed.length + (isLoading ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == displayed.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridViewModel(char: displayed[i]);
                  },
                ),
              )
            : Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: displayed.length + (isLoading ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == displayed.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final c = displayed[i];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                CharacterDetailScreen(char: c, ep: null),
                          ),
                        );
                      },
                      child: ListTileModel(char: c),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
