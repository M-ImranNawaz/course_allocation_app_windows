import 'dart:convert';

class RegFaculty {
  int id;
  String name;
  String email;
  String password;
  RegFaculty({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory RegFaculty.fromMap(Map<String, dynamic> map) {
    return RegFaculty(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  static RegFaculty fromJson(json) => RegFaculty(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password']
      );
  @override
  String toString() {
    return 'RegFaculty(id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegFaculty &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
