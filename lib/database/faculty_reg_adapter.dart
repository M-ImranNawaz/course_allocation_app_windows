import 'package:hive/hive.dart';

part 'faculty_reg_adapter.g.dart';

@HiveType(typeId: 6)
class FacultyReg extends HiveObject {
  FacultyReg({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  double password;
}
