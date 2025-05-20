import '../helpers/constants.dart';


class AuthUser {
  String? id;
  String? name;
  String? email;
  String? image;
  String? createdAt;
  String? token;

  AuthUser({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.token,
    this.image,
  });

  @override
  String toString() {
    return '''AuthUser(
      id: $id,
      name: $name,
      email: $email,
      createdAt: $createdAt,
      token: $token,
   )''';
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'] != null ? baseURLFile + json['image'] : null,
      createdAt: json['createdAt'],
      token: json['token'],
    );
  }
}
