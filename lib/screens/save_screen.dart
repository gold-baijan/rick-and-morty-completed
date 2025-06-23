import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';
import 'package:rick_and_morty2/model/fav_character.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<FavCharacter>('favorites');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0b1e2d) : AppColors.backgroundLight,
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<FavCharacter> box, _) {
          final saved = box.values.toList();
      
          if (saved.isEmpty) {
            return const Center(
              child: Text(
                'No saved characters',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
      
          return Container(
            color: isDark ? Color(0xFF0b1e2d) : AppColors.backgroundLight,
            child: ListView.builder(
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final character = saved[index];
                return ListTile(
                  contentPadding: EdgeInsets.only(top: 16, left: 20, right: 20),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => box.deleteAt(index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
