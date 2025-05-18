import 'dart:convert';
import 'package:http/http.dart' as http;

abstract interface class IHttpService {
  Future<HttpResponseEntity> fetchData(String url, int page);
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
}

final class HttpResponseEntity {
  final List<dynamic> results;

  HttpResponseEntity({required this.results});

  factory HttpResponseEntity.fromJson(Map<String, dynamic> json) {
    return HttpResponseEntity(
      results: json['results'] as List<dynamic>,
    );
  }
}
