import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String password;
  BigInt no_telp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.no_telp,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        no_telp: json['no_telp'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'no_telp': no_telp,
      };
}
