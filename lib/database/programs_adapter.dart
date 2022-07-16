import 'package:hive/hive.dart';

part 'programs_adapter.g.dart';

@HiveType(typeId: 1)
class Program extends HiveObject {
  Program({
    required this.name,
    this.description,
  });
  @HiveField(0)
  String name;
  @HiveField(1)
  String? description;
}
