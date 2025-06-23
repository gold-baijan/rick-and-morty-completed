// import 'package:shared_preferences/shared_preferences.dart';

// class FavoritesService {
//   static const String _key = 'favorite_characters';

//   Future<List<int>> getFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getStringList(_key)?.map(int.parse).toList() ?? [];
//   }

//   Future<void> addFavorite(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final current = await getFavorites();
//     if (!current.contains(id)) {
//       current.add(id);
//       await prefs.setStringList(_key, current.map((e) => e.toString()).toList());
//     }
//   }

//   Future<void> removeFavorite(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final current = await getFavorites();
//     current.remove(id);
//     await prefs.setStringList(_key, current.map((e) => e.toString()).toList());
//   }

//   Future<bool> isFavorite(int id) async {
//     final current = await getFavorites();
//     return current.contains(id);
//   }
// }