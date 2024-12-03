import 'package:tubes_pbp_9/entity/fnb.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FoodnBev {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/foodbev';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Foodbev>> fetchByCategory(String category) async {
    final Uri url = Uri.http(baseUrl, endpoint, {'category': category});

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
        return jsonData.map((data) => Foodbev.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
