// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_reg_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacultyRegAdapter extends TypeAdapter<FacultyReg> {
  @override
  final int typeId = 6;

  @override
  FacultyReg read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacultyReg(
      id: fields[0] as int?,
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FacultyReg obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacultyRegAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
