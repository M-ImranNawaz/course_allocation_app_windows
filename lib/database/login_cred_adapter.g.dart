// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cred_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginCredAdapter extends TypeAdapter<LoginCred> {
  @override
  final int typeId = 3;

  @override
  LoginCred read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginCred(
      id: fields[0] as String?,
      name: fields[1] as String?,
      department: fields[2] as String?,
      email: fields[3] as String?,
      password: fields[4] as String?,
      isLoggedIn: fields[5] as bool?,
      token: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginCred obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.isLoggedIn)
      ..writeByte(6)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginCredAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
