import 'package:tubes_pbp_9/entity/fnb.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodnBev {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/foodbev';

  static Future<List<Foodbev>> fetchByCategory(String category) async {
    final Uri url = Uri.http(baseUrl, endpoint, {'category': category});

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer 1|M3X3sEQpmXxLLAHD9POWYCdV6u7ds06C5laNIWq751027286',
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
