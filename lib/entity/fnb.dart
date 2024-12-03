import 'dart:convert';

class Foodbev {
  int id;
  String gambar;
  String name;
  String deskripsi;
  double harga;
  String kategori;

  Foodbev({
    required this.id,
    required this.gambar,
    required this.name,
    required this.deskripsi,
    required this.harga,
    required this.kategori,
  });

  factory Foodbev.fromRawJson(String str) => Foodbev.fromJson(json.decode(str));
  factory Foodbev.fromJson(Map<String, dynamic> json) => Foodbev(
        id: json['id'],
        gambar: json['gambar'],
        name: json['name'],
        deskripsi: json['deskripsi'],
        harga: json['harga'] is String
            ? double.tryParse(json['harga']) ?? 0.0
            : json['harga'],
        kategori: json['kategori'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'gambar': gambar,
        'name': name,
        'deskripsi': deskripsi,
        'harga': harga,
        'kategori': kategori,
      };
}
