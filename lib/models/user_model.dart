// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int id;
  final String email;
  final String token;
  final String name;
  final String registrationType;

  UserModel({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
    required this.registrationType,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? token,
    String? name,
    String? registerationType,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      name: name ?? this.name,
      registrationType: registerationType ?? this.registrationType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
      'name': name,
      'registerationType': registrationType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      token: map['token'] as String,
      name: map['name'] as String,
      registrationType: map['registerationType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, token: $token, name: $name, registerationType: $registrationType)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.token == token &&
        other.name == name &&
        other.registrationType == registrationType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        token.hashCode ^
        name.hashCode ^
        registrationType.hashCode;
  }
}
