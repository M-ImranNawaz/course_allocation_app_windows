import 'dart:convert';

class AllocatedCourse {
  int id;
  String faculty;
  String courses;
  AllocatedCourse({
    required this.id,
    required this.faculty,
    required this.courses,
  });

  AllocatedCourse copyWith({
    int? id,
    String? faculty,
    String? courses,
  }) {
    return AllocatedCourse(
      id: id ?? this.id,
      faculty: faculty ?? this.faculty,
      courses: courses ?? this.courses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'faculty': faculty,
      'courses': courses,
    };
  }

  factory AllocatedCourse.fromMap(Map<String, dynamic> map) {
    return AllocatedCourse(
      id: map['id']?.toInt() ?? 0,
      faculty: map['faculty'] ?? '',
      courses: map['courses'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AllocatedCourse.fromJson(String source) =>
      AllocatedCourse.fromMap(json.decode(source));

  @override
  String toString() =>
      'AllocatedCourse(id: $id, faculty: $faculty, courses: $courses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllocatedCourse &&
        other.id == id &&
        other.faculty == faculty &&
        other.courses == courses;
  }

  @override
  int get hashCode => id.hashCode ^ faculty.hashCode ^ courses.hashCode;
}
