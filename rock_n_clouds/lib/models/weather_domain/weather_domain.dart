import 'package:hive/hive.dart';

class WeatherDomain extends HiveObject {
  String? country;
  String? areaName;
  String? weatherMain;
  String? weatherDescription;
  String? weatherIcon;
  TemperatureDomain? temperature;
  TemperatureDomain? tempMin;
  TemperatureDomain? tempMax;
  TemperatureDomain? tempFeelsLike;

  DateTime? date;
  DateTime? sunrise;
  DateTime? sunset;

  double? latitude;
  double? longitude;
  double? pressure;
  double? windSpeed;
  double? windDegree;
  double? windGust;
  double? humidity;
  double? cloudiness;
  double? rainLastHour;
  double? rainLast3Hours;
  double? snowLastHour;
  double? snowLast3Hours;

  int? weatherConditionCode;

  WeatherDomain({
    this.country,
    this.areaName,
    this.weatherMain,
    this.weatherDescription,
    this.weatherIcon,
    this.temperature,
    this.tempMin,
    this.tempMax,
    this.tempFeelsLike,
    this.date,
    this.sunrise,
    this.sunset,
    this.latitude,
    this.longitude,
    this.pressure,
    this.windSpeed,
    this.windDegree,
    this.windGust,
    this.humidity,
    this.cloudiness,
    this.rainLastHour,
    this.rainLast3Hours,
    this.snowLastHour,
    this.snowLast3Hours,
    this.weatherConditionCode,
  });
}

class TemperatureDomain {
  double? kelvin;
}
