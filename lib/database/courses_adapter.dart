import 'package:hive/hive.dart';

part 'courses_adapter.g.dart';

@HiveType(typeId: 4)
class Course extends HiveObject {
  Course({
    required this.name,
    required this.code,
    required this.creditHours,
    this.program,
    this.department,
    this.semester
  });
  @HiveField(0)
  String name;
  @HiveField(1)
  String code;
  @HiveField(2)
  int creditHours;
  @HiveField(3)
  String? program;
  @HiveField(4)
  String? department;
  @HiveField(5)
  String? semester;
}
