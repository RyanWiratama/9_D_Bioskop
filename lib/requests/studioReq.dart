import 'package:tubes_pbp_9/entity/studio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudioReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/studio';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Studio>> fetchAllStudios() async {
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
        return jsonData.map((data) => Studio.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load studios: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Studio> fetchStudioById(int id) async {
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
        return Studio.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load studio: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Studio> createStudio(Studio studio) async {
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
        body: studio.toRawJson(),
      );

      if (response.statusCode == 201) {
        return Studio.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create studio: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
