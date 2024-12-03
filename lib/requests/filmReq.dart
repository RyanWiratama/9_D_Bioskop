import 'package:tubes_pbp_9/entity/film.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FilmReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/film';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Film>> fetchAllFilms() async {
    final Uri url = Uri.http(baseUrl, endpoint);
  
  static Future<List<Film>> fetchall() async {
    final Uri url = Uri.http(baseUrl, endpoint);

  static Future<List<Film>> fetchByGenre(String genre) async {
    final Uri url = Uri.http(baseUrl, endpoint, {'genre': genre});

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => Film.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Film> fetchFilmById(int id) async {
    final Uri url = Uri.http(baseUrl, '$endpoint/$id');

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Film.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load film: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
