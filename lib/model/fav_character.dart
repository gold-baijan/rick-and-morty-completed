import 'package:hive/hive.dart';

part 'fav_character.g.dart';

@HiveType(typeId: 0)
class FavCharacter extends HiveObject {
  @HiveField(0)
  final int id;
  
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  FavCharacter({required this.id, required this.name, required this.image});
}
