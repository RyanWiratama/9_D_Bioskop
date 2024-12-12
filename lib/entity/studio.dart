import 'dart:convert';

class Studio {
  int id;
  String nama;
  int kapasitas;

  Studio({
    required this.id,
    required this.nama,
    required this.kapasitas,
  });

  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      id: json['id'],
      nama: json['nama'],
      kapasitas: json['kapasitas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kapasitas': kapasitas,
    };
  }

  String toRawJson() => json.encode(toJson());
}
