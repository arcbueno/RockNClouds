// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_domain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherDomainAdapter extends TypeAdapter<WeatherDomain> {
  @override
  final int typeId = 1;

  @override
  WeatherDomain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDomain(
      country: fields[0] as String?,
      areaName: fields[1] as String?,
      weatherMain: fields[2] as String?,
      weatherDescription: fields[3] as String?,
      weatherIcon: fields[4] as String?,
      temperature: fields[5] as TemperatureDomain?,
      tempMin: fields[6] as TemperatureDomain?,
      tempMax: fields[7] as TemperatureDomain?,
      tempFeelsLike: fields[8] as TemperatureDomain?,
      date: fields[9] as DateTime?,
      sunrise: fields[10] as DateTime?,
      sunset: fields[11] as DateTime?,
      latitude: fields[12] as double?,
      longitude: fields[13] as double?,
      pressure: fields[14] as double?,
      windSpeed: fields[15] as double?,
      windDegree: fields[16] as double?,
      windGust: fields[17] as double?,
      humidity: fields[18] as double?,
      cloudiness: fields[19] as double?,
      rainLastHour: fields[20] as double?,
      rainLast3Hours: fields[21] as double?,
      snowLastHour: fields[22] as double?,
      snowLast3Hours: fields[23] as double?,
      weatherConditionCode: fields[24] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDomain obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.areaName)
      ..writeByte(2)
      ..write(obj.weatherMain)
      ..writeByte(3)
      ..write(obj.weatherDescription)
      ..writeByte(4)
      ..write(obj.weatherIcon)
      ..writeByte(5)
      ..write(obj.temperature)
      ..writeByte(6)
      ..write(obj.tempMin)
      ..writeByte(7)
      ..write(obj.tempMax)
      ..writeByte(8)
      ..write(obj.tempFeelsLike)
      ..writeByte(9)
      ..write(obj.date)
      ..writeByte(10)
      ..write(obj.sunrise)
      ..writeByte(11)
      ..write(obj.sunset)
      ..writeByte(12)
      ..write(obj.latitude)
      ..writeByte(13)
      ..write(obj.longitude)
      ..writeByte(14)
      ..write(obj.pressure)
      ..writeByte(15)
      ..write(obj.windSpeed)
      ..writeByte(16)
      ..write(obj.windDegree)
      ..writeByte(17)
      ..write(obj.windGust)
      ..writeByte(18)
      ..write(obj.humidity)
      ..writeByte(19)
      ..write(obj.cloudiness)
      ..writeByte(20)
      ..write(obj.rainLastHour)
      ..writeByte(21)
      ..write(obj.rainLast3Hours)
      ..writeByte(22)
      ..write(obj.snowLastHour)
      ..writeByte(23)
      ..write(obj.snowLast3Hours)
      ..writeByte(24)
      ..write(obj.weatherConditionCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDomainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemperatureDomainAdapter extends TypeAdapter<TemperatureDomain> {
  @override
  final int typeId = 2;

  @override
  TemperatureDomain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemperatureDomain(
      fields[0] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, TemperatureDomain obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.kelvin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperatureDomainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
