import 'dart:convert';
import 'package:tubes_pbp_9/entity/user.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';

class Transaksi {
  final int id;
  final int idUser;
  final int idJadwal;
  int totalTiket;
  final double? totalHarga;
  final User? user; // Relasi ke User
  final Jadwal? jadwal; // Relasi ke Jadwal

  Transaksi({
    required this.id,
    required this.idUser,
    required this.idJadwal,
    required this.totalTiket,
    required this.totalHarga,
    this.user,
    this.jadwal,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      idUser: json['id_user'],
      idJadwal: json['id_jadwal'],
      totalTiket: json['total_tiket'],
      totalHarga: json['total_harga'].toDouble(),
      // user: json['user'] != null ? User.fromJson(json['user']) : null,
      // jadwal: json['jadwal'] != null ? Jadwal.fromJson(json['jadwal']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_jadwal': idJadwal,
      'total_tiket': totalTiket,
      'total_harga': totalHarga,
      // 'user': user?.toJson(),
      // 'jadwal': jadwal?.toJson(),
    };
  }
}
