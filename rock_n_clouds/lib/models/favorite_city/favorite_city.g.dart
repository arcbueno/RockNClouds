// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCityAdapter extends TypeAdapter<FavoriteCity> {
  @override
  final int typeId = 3;

  @override
  FavoriteCity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCity(
      areaName: fields[0] as String?,
      country: fields[1] as String?,
      lat: fields[2] as double?,
      lon: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.areaName)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
