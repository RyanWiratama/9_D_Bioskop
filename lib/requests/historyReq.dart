import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubes_pbp_9/entity/history.dart';

class HistoryReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/history';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<History>> fetchAllHistories() async {
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

        for (var historyData in jsonData) {
          if (historyData['film'] == null) {
            throw Exception('Film data is missing in the history');
          }
        }

        return jsonData.map((data) => History.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<History> fetchHistoryById(int id) async {
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
        return History.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load history: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<History> createHistory(History history) async {
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
        body: jsonEncode(history.toJson()),
      );

      if (response.statusCode == 201) {
        return History.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create history: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
