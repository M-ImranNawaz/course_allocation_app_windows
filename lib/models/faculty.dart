import 'dart:convert';

import 'package:flutter/foundation.dart';

class Faculty {
  String id;
  String uName;
  String password;
  String department;
  String designation;
  List expertise;
  Faculty({
    required this.id,
    required this.uName,
    required this.password,
    required this.department,
    required this.designation,
    required this.expertise,
  });

  Faculty copyWith({
    String? id,
    String? uName,
    String? password,
    String? department,
    String? designation,
    List? expertise,
  }) {
    return Faculty(
      id: id ?? this.id,
      uName: uName ?? this.uName,
      password: password ?? this.password,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      expertise: expertise ?? this.expertise,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uName': uName,
      'password': password,
      'department': department,
      'designation': designation,
      'expertise': expertise,
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      id: map['id'] ?? '',
      uName: map['uName'] ?? '',
      password: map['password'] ?? '',
      department: map['department'] ?? '',
      designation: map['designation'] ?? '',
      expertise: List.from(map['expertise']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Faculty(id: $id, uName: $uName, password: $password, department: $department, designation: $designation, expertise: $expertise)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Faculty &&
        other.id == id &&
        other.uName == uName &&
        other.password == password &&
        other.department == department &&
        other.designation == designation &&
        listEquals(other.expertise, expertise);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uName.hashCode ^
        password.hashCode ^
        department.hashCode ^
        designation.hashCode ^
        expertise.hashCode;
  }
}
