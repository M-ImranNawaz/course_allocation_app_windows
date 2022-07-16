import 'dart:convert';

class SCourse {
  int id;
  String name;
  String code;
  String department;
  String program;
  String creditHours;
  String semester;
  SCourse({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.program,
    required this.creditHours,
    required this.semester,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'department': department,
      'program': program,
      'creditHours': creditHours,
      'semester': semester
    };
  }

  factory SCourse.fromMap(Map<String, dynamic> map) {
    return SCourse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      department: map['department'] ?? '',
      program: map['program'] ?? '',
      creditHours: map['creditHours']?.toInt() ?? 0,
      semester: map['semester']?.String() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory SCourse.fromJson(String source) =>
  //     SCourse.fromMap(json.decode(source));

  static SCourse fromJson(json) => SCourse(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        department: json['department'],
        program: json['program'],
        creditHours: json['creditHours'],
        semester: json['semester'],
      );
}
