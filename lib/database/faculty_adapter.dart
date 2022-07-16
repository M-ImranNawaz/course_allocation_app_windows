import 'package:hive/hive.dart';

part 'faculty_adapter.g.dart';

@HiveType(typeId: 5)
class Faculty extends HiveObject {
  Faculty(
      {required this.name,
      required this.designation,
      required this.maxWorkload,
      this.department,
      required this.experience});
  @HiveField(0)
  String name;
  @HiveField(1)
  String designation;
  @HiveField(2)
  int maxWorkload;
  @HiveField(3)
  String? department;
  @HiveField(4)
  double experience;
}
