// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacultyAdapter extends TypeAdapter<Faculty> {
  @override
  final int typeId = 5;

  @override
  Faculty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Faculty(
      name: fields[0] as String,
      designation: fields[1] as String,
      maxWorkload: fields[2] as int,
      department: fields[3] as String?,
      experience: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Faculty obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.designation)
      ..writeByte(2)
      ..write(obj.maxWorkload)
      ..writeByte(3)
      ..write(obj.department)
      ..writeByte(4)
      ..write(obj.experience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
