import 'dart:convert';

class Foodbev {
  int id;
  String name;
  String deskripsi;
  double harga;
  String kategori;

  Foodbev({
    required this.id,
    required this.name,
    required this.deskripsi,
    required this.harga,
    required this.kategori,
  });

  factory Foodbev.fromRawJson(String str) => Foodbev.fromJson(json.decode(str));
  factory Foodbev.fromJson(Map<String, dynamic> json) => Foodbev(
        id: json['id'],
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
        'name': name,
        'deskripsi': deskripsi,
        'harga': harga,
        'kategori': kategori,
      };
}
