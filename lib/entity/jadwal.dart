import 'dart:convert';

class Jadwal {
  int id;
  int idFilm;
  int idStudio;
  String tanggal; // Ubah jenis data menjadi DateTime
  String jamTayang;
  int harga;

  Jadwal({
    required this.id,
    required this.idFilm,
    required this.idStudio,
    required this.tanggal,
    required this.jamTayang,
    required this.harga,
  });

  factory Jadwal.fromRawJson(String str) => Jadwal.fromJson(json.decode(str));

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      idFilm: json['id_film'],
      idStudio: json['id_studio'],
      tanggal: json['tanggal'], // Parse tanggal menjadi DateTime
      jamTayang: json['jam_tayang'],
      harga: json['harga'],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_film': idFilm,
        'id_studio': idStudio,
        'tanggal': tanggal,
        'jam_tayang': jamTayang,
        'harga': harga,
      };
}
