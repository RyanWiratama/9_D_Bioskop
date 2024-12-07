import 'dart:convert';
import 'history.dart'; 
import 'user.dart';

class Review {
  int id;
  int idUser;
  int idHistory;
  int rating;
  String komentar;
  History history;
  User user;

  Review({
    required this.id,
    required this.idUser,
    required this.idHistory,
    required this.rating,
    required this.komentar,
    required this.history,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      idUser: json['id_user'],
      idHistory: json['id_history'],
      rating: json['rating'],
      komentar: json['komentar'] ?? '',
      history: History.fromJson(json['history']),
      user: User.fromJson(json['user']), 
      // history: json['history'] != null
      //     ? History.fromJson(json['history'])
      //     : History(id: 0, idFilm: 0, idUser: 0, tanggalNonton: '', film: {}),
      // user: json['user'] != null
      //     ? User.fromJson(json['user']) // Mengambil data user
      //     : User(id: 0, name: '', email: ''), // Menyediakan data default jika user tidak ada
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': idUser,
        'id_history': idHistory,
        'rating': rating,
        'komentar': komentar,
        'history': history.toJson(),
        'user': user.toJson(),
      };
}
