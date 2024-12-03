import 'dart:convert';

class Film {
  int id;
  String judul;
  String deskripsi;
  String durasi;
  String genre;
  String sutradara;
  String ratingUsia;
  String poster;
  String trailer;

  Film({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.durasi,
    required this.genre,
    required this.sutradara,
    required this.ratingUsia,
    required this.poster,
    required this.trailer,
  });

  factory Film.fromRawJson(String str) => Film.fromJson(json.decode(str));
  factory Film.fromJson(Map<String, dynamic> json) => Film(
        id: json['id'],
        judul: json['judul'],
        deskripsi: json['deskripsi'],
        durasi: json['durasi'],
        genre: json['genre'],
        sutradara: json['sutradara'],
        ratingUsia: json['ratingUsia'],
        poster: json['poster'],
        trailer: json['trailer'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'deskripsi': deskripsi,
        'durasi': durasi,
        'genre': genre,
        'sutradara': sutradara,
        'ratingUsia': ratingUsia,
        'poster': poster,
        'trailer': trailer,
      };
}
