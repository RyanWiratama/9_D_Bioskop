import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubes_pbp_9/entity/transaksi.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'package:tubes_pbp_9/entity/user.dart';

class TransaksiReq {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/transaksi';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<List<Transaksi>> fetchAllTransaksi() async {
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
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Transaksi.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      print('Error in fetchAllTransaksi: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<Transaksi> createTransaksi(Transaksi transaksi) async {
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
        body: jsonEncode(transaksi.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return Transaksi.fromJson(jsonResponse['transaksi']);
      } else {
        throw Exception('Failed to create transaction');
      }
    } catch (e) {
      print('Error in createTransaksi: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<Transaksi> fetchTransaksiById(int id) async {
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
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return Transaksi.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch transaction');
      }
    } catch (e) {
      print('Error in fetchTransaksiById: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<Transaksi> updateTransaksi(int id, Transaksi transaksi) async {
    final Uri url = Uri.http(baseUrl, '$endpoint/$id');

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(transaksi.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return Transaksi.fromJson(jsonResponse['transaksi']);
      } else {
        throw Exception('Failed to update transaction');
      }
    } catch (e) {
      print('Error in updateTransaksi: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<void> deleteTransaksi(int id) async {
    final Uri url = Uri.http(baseUrl, '$endpoint/$id');

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete transaction');
      }
    } catch (e) {
      print('Error in deleteTransaksi: $e');
      throw Exception('Error: $e');
    }
  }
}
