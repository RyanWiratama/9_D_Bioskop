class Review {
  int? id;
  int? idUser;
  int? idHistory;
  int? rating;
  String komentar;

  Review({
    this.id,
    this.idUser,
    this.idHistory,
    required this.rating,
    required this.komentar,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      idUser: json['id_user'],
      idHistory: json['id_history'] ?? 0,
      rating: json['rating'] ?? 0,
      komentar: json['komentar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': idUser,
        'id_history': idHistory,
        'rating': rating,
        'komentar': komentar,
      };
}
