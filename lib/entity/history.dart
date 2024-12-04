import 'dart:convert';
import 'film.dart'; // Import Film model

class History {
  int id;
  int idFilm;
  int idUser;
  String tanggalNonton;
  Film film;

  History({
    required this.id,
    required this.idFilm,
    required this.idUser,
    required this.tanggalNonton,
    required this.film,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      idFilm: json['id_film'],
      idUser: json['id_user'],
      tanggalNonton: json['tanggal_nonton'] ?? '',
      film: json['film'] != null
          ? Film.fromJson(json['film'])
          : Film.fromJson({}),
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_film': idFilm,
        'id_user': idUser,
        'tanggal_nonton': tanggalNonton,
        'film': film.toJson(),
      };
}
