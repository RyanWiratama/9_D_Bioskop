import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpointRegister = '/api/register';
  static final String endpointLogin = '/api/login';
  static final String endpointLogout = '/api/logout';
  static final String endpointUpdateName = '/api/user/update/name';
  static final String endpointUpdateEmail = '/api/user/update/email';

  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<http.Response> register(Map<String, String> data) async {
    final Uri url = Uri.http(baseUrl, endpointRegister);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<http.Response> login(Map<String, String> data) async {
    final Uri url = Uri.http(baseUrl, endpointLogin);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final String token = responseBody['token'];
        final FlutterSecureStorage storage = FlutterSecureStorage();

        await storage.write(key: 'token', value: token);

        return response;
      } else {
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> logout() async {
    final Uri url = Uri.http(baseUrl, endpointLogout);
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await storage.deleteAll();
      } else {
        throw Exception('Failed to logout: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    final Uri url = Uri.http(baseUrl, '/api/user');
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to fetch user details: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<http.Response> updateUserName(String newName) async {
    final Uri url = Uri.http(baseUrl, endpointUpdateName);
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': newName}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update name: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<http.Response> updateUserEmail(String newEmail) async {
    final Uri url = Uri.http(baseUrl, endpointUpdateEmail);
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('No token found');
    }
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': newEmail}),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update email: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<http.Response> updateUserPhone(String newPhone) async {
    final Uri url = Uri.http(baseUrl, '/api/user/update/phone');
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'no_telp': newPhone}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to update phone number: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<http.Response> updateUserPassword(
      String currentPassword, String newPassword) async {
    final Uri url = Uri.http(baseUrl, '/api/user/update/password');
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update password: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
