class Transaksi {
  final int id;
  final int idUser;
  final int idJadwal;
  final int totalTiket;
  final double totalHarga;

  Transaksi({
    required this.id,
    required this.idUser,
    required this.idJadwal,
    required this.totalTiket,
    required this.totalHarga,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      idUser: json['id_user'],
      idJadwal: json['id_jadwal'],
      totalTiket: json['total_tiket'],
      totalHarga: json['total_harga'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_jadwal': idJadwal,
      'total_tiket': totalTiket,
      'total_harga': totalHarga,
    };
  }
}
