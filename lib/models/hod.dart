import 'dart:convert';

class HOD {
  String id;
  String name;
  String department;
  String email;
  String password;
  HOD({
    required this.id,
    required this.name,
    required this.department,
    required this.email,
    required this.password,
  });

  HOD copyWith({
    String? id,
    String? name,
    String? department,
    String? email,
    String? password,
  }) {
    return HOD(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'email': email,
      'password': password,
    };
  }

  factory HOD.fromMap(Map<String, dynamic> map) {
    return HOD(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HOD.fromJson(String source) => HOD.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HOD(id: $id, name: $name, department: $department, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HOD &&
        other.id == id &&
        other.name == name &&
        other.department == department &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        department.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
