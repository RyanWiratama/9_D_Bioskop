import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubes_pbp_9/entity/review.dart';

class ReviewReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/review';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // Fetch all reviews
  static Future<List<Review>> fetchAllReviews() async {
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

        // Ensure all reviews have history and user data
        for (var reviewData in jsonData) {
          if (reviewData['history'] == null) {
            throw Exception('History data is missing in the review');
          }
          if (reviewData['user'] == null) {
            throw Exception('User data is missing in the review');
          }
        }

        return jsonData.map((data) => Review.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch review by ID
  static Future<Review> fetchReviewById(int id) async {
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
        return Review.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load review: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Review> createReview(Review review) async {
    final Uri url = Uri.http(baseUrl, '/api/review/create');

    try {
      print('Debug: URL - $url');

      final storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_history': review.idHistory,
          'rating': review.rating,
          'komentar': review.komentar.trim(),
        }),
      );

      print('Debug: Response status code - ${response.statusCode}');
      print('Debug: Response body - ${response.body}');

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return Review.fromJson(responseBody['post']);
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception(
            'Failed to create review: ${responseBody['error'] ?? response.body}');
      }
    } catch (e) {
      throw Exception('Error creating review: $e');
    }
  }
}
