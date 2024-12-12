import 'dart:convert';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/entity/film.dart';

class Jadwal {
  int id;
  int idFilm;
  int idStudio;
  String tanggal;
  String jamTayang;
  String harga;
  Studio? studio;
  Film? film;

  Jadwal({
    required this.id,
    required this.idFilm,
    required this.idStudio,
    required this.tanggal,
    required this.jamTayang,
    required this.harga,
    this.studio,
    this.film,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      idFilm: json['id_film'],
      idStudio: json['id_studio'],
      tanggal: json['tanggal'],
      jamTayang: json['jam_tayang'],
      harga: json['harga'],
      studio: json['studio'] != null ? Studio.fromJson(json['studio']) : null,
      film: json['film'] != null ? Film.fromJson(json['film']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_film': idFilm,
      'id_studio': idStudio,
      'tanggal': tanggal,
      'jam_tayang': jamTayang,
      'harga': harga,
      // 'studio': studio?.toJson(),
      // 'film': film?.toJson(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
