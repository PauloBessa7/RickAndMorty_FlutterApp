import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_game/models/character.dart';

abstract interface class IHttpService {
  Future<HttpResponseEntity> fetchData(String url, int page);
  Future<Character> fetchDataWithId(String url, int id);
}

final class HttpService implements IHttpService {
  @override
  Future<HttpResponseEntity> fetchData(String url, int page) async {
    final response = await http.get(Uri.parse('$url?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return HttpResponseEntity.fromJson(data);
    } else {
      throw Exception('Erro ao carregar dados: ${response.statusCode}');
    }
  }

  @override
  Future<Character> fetchDataWithId(String url, int id) async {
  final uri = Uri.parse('https://rickandmortyapi.com/api/character/$id');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Character.fromJson(data);
  } else {
    throw Exception('Erro ao carregar personagem: ${response.statusCode}');
  }
}

}

final class HttpResponseEntity {
  final List<dynamic> results;

  HttpResponseEntity({required this.results});

  factory HttpResponseEntity.fromJson(Map<String, dynamic> json) {
    return HttpResponseEntity(results: json['results'] as List<dynamic>);
  }
}
