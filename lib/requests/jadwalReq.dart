import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JadwalReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/jadwal';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Jadwal>> fetchAllJadwal() async {
    final Uri url = Uri.http(baseUrl, endpoint);

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
        return jsonData.map((data) => Jadwal.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load jadwal: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Jadwal> fetchJadwalById(int id) async {
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
        return Jadwal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load jadwal: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<Jadwal>> fetchShowtimesByFilmId(int filmId) async {
    final Uri url = Uri.http(baseUrl,
        '$endpoint/film/$filmId'); // Endpoint to fetch showtimes for a specific film

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
        return jsonData.map((data) => Jadwal.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load showtimes: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Jadwal> createJadwal(Jadwal jadwal) async {
    final Uri url = Uri.http(baseUrl, endpoint);

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jadwal.toRawJson(),
      );

      if (response.statusCode == 201) {
        return Jadwal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create jadwal: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
