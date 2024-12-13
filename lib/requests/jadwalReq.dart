import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JadwalReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/jadwal';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Jadwal>> fetchAllJadwal(int id) async {
    final Uri url = Uri.http(baseUrl, '/api/studio/jadwalfilm');

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
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['jadwals'] != null) {
          final List<dynamic> jadwalData = jsonResponse['jadwals'] is List
              ? jsonResponse['jadwals']
              : [jsonResponse['jadwals']];

          return jadwalData.map((data) {
            final jadwal = Jadwal.fromJson(data);

            if (data['studio'] != null) {
              jadwal.studio = Studio.fromJson(data['studio']);
            }
            if (data['film'] != null) {
              jadwal.film = Film.fromJson(data['film']);
            }

            return jadwal;
          }).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load jadwal: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in fetchAllJadwal: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<List<Jadwal>> fetchShowtimesByFilmId(int filmId) async {
    final Uri url = Uri.http(baseUrl, '$endpoint/$filmId/jadwalfilm');

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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['jadwals'] != null) {
          final List<dynamic> jadwalData = jsonResponse['jadwals'] is List
              ? jsonResponse['jadwals']
              : [jsonResponse['jadwals']];

          return jadwalData.map((data) {
            try {
              final jadwal = Jadwal.fromJson(data);

              if (data['studio'] != null) {
                jadwal.studio = Studio.fromJson(data['studio']);
              }
              if (data['film'] != null) {
                jadwal.film = Film.fromJson(data['film']);
              }

              return jadwal;
            } catch (e) {
              print('Error parsing jadwal data: $e');
              print('Problematic data: $data');
              rethrow;
            }
          }).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load showtimes: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in fetchShowtimesByFilmId: $e');
      throw Exception('Error: $e');
    }
  }
}
