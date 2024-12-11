import 'dart:convert';

class Studio {
  int id;
  int kapasitas;
  String nama;

  Studio({
    required this.id,
    required this.kapasitas,
    required this.nama,
  });

  factory Studio.fromRawJson(String str) => Studio.fromJson(json.decode(str));
  factory Studio.fromJson(Map<String, dynamic> json) => Studio(
        id: json['id'],
        kapasitas: json['kapasitas'],
        nama: json['nama'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'kapasitas': kapasitas,
        'nama': nama,
      };
}
