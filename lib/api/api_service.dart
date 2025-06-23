import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty2/api/api_character.dart';

Future<CharacterResponse> fetchCharacterPage(int page) async {
  final url = Uri.parse('https://rickandmortyapi.com/api/character/?page=$page');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    return CharacterResponse.fromJson(json.decode(res.body));
  } else {
    throw Exception('Ошибка загрузки: ${res.statusCode}');
  }
  
  
}
Future<Character> fetchCharacterById(int id) async {
  final url = Uri.parse('https://rickandmortyapi.com/api/character/$id');
  final res = await http.get(url);

  if (res.statusCode == 200) {
    return Character.fromJson(json.decode(res.body));
  } else {
    throw Exception('Ошибка загрузки персонажа id: $id');
  }
}