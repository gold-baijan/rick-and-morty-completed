// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavCharacterAdapter extends TypeAdapter<FavCharacter> {
  @override
  final int typeId = 0;

  @override
  FavCharacter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavCharacter(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavCharacter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavCharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
