// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationUserAdapter extends TypeAdapter<AuthenticationUser> {
  @override
  final int typeId = 0;

  @override
  AuthenticationUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationUser(
      photo: fields[0] as String,
      snfn: fields[1] as String,
      location: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.snfn)
      ..writeByte(2)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
