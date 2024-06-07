import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/weather.dart';

part 'weather_domain.g.dart';

@HiveType(typeId: 1)
class WeatherDomain extends HiveObject {
  @HiveField(0)
  String? country;
  @HiveField(1)
  String? areaName;
  @HiveField(2)
  String? weatherMain;
  @HiveField(3)
  String? weatherDescription;
  @HiveField(4)
  String? weatherIcon;
  @HiveField(5)
  TemperatureDomain? temperature;
  @HiveField(6)
  TemperatureDomain? tempMin;
  @HiveField(7)
  TemperatureDomain? tempMax;
  @HiveField(8)
  TemperatureDomain? tempFeelsLike;
  @HiveField(9)
  DateTime? date;
  @HiveField(10)
  DateTime? sunrise;
  @HiveField(11)
  DateTime? sunset;
  @HiveField(12)
  double? latitude;
  @HiveField(13)
  double? longitude;
  @HiveField(14)
  double? pressure;
  @HiveField(15)
  double? windSpeed;
  @HiveField(16)
  double? windDegree;
  @HiveField(17)
  double? windGust;
  @HiveField(18)
  double? humidity;
  @HiveField(19)
  double? cloudiness;
  @HiveField(20)
  double? rainLastHour;
  @HiveField(21)
  double? rainLast3Hours;
  @HiveField(22)
  double? snowLastHour;
  @HiveField(23)
  double? snowLast3Hours;
  @HiveField(24)
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

  factory WeatherDomain.fromWeather(Weather weather) {
    return WeatherDomain(
      country: weather.country,
      areaName: weather.areaName,
      weatherMain: weather.weatherMain,
      weatherDescription: weather.weatherDescription,
      weatherIcon: weather.weatherIcon,
      temperature: TemperatureDomain(weather.temperature?.kelvin),
      tempMin: TemperatureDomain(weather.tempMin?.kelvin),
      tempMax: TemperatureDomain(weather.tempMax?.kelvin),
      tempFeelsLike: TemperatureDomain(weather.tempFeelsLike?.kelvin),
      date: weather.date,
      sunrise: weather.sunrise,
      sunset: weather.sunset,
      latitude: weather.latitude,
      longitude: weather.longitude,
      pressure: weather.pressure,
      windSpeed: weather.windSpeed,
      windDegree: weather.windDegree,
      windGust: weather.windGust,
      humidity: weather.humidity,
      cloudiness: weather.cloudiness,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherDomain &&
        other.country == country &&
        other.areaName == areaName &&
        other.weatherMain == weatherMain &&
        other.weatherDescription == weatherDescription &&
        other.weatherIcon == weatherIcon &&
        other.temperature == temperature &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.tempFeelsLike == tempFeelsLike &&
        other.date == date &&
        other.sunrise == sunrise &&
        other.sunset == sunset &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.pressure == pressure &&
        other.windSpeed == windSpeed &&
        other.windDegree == windDegree &&
        other.windGust == windGust &&
        other.humidity == humidity &&
        other.cloudiness == cloudiness &&
        other.rainLastHour == rainLastHour &&
        other.rainLast3Hours == rainLast3Hours &&
        other.snowLastHour == snowLastHour &&
        other.snowLast3Hours == snowLast3Hours &&
        other.weatherConditionCode == weatherConditionCode;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        areaName.hashCode ^
        weatherMain.hashCode ^
        weatherDescription.hashCode ^
        weatherIcon.hashCode ^
        temperature.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        tempFeelsLike.hashCode ^
        date.hashCode ^
        sunrise.hashCode ^
        sunset.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        pressure.hashCode ^
        windSpeed.hashCode ^
        windDegree.hashCode ^
        windGust.hashCode ^
        humidity.hashCode ^
        cloudiness.hashCode ^
        rainLastHour.hashCode ^
        rainLast3Hours.hashCode ^
        snowLastHour.hashCode ^
        snowLast3Hours.hashCode ^
        weatherConditionCode.hashCode;
  }
}

@HiveType(typeId: 2)
class TemperatureDomain {
  @HiveField(0)
  double? kelvin;

  TemperatureDomain(
    this.kelvin,
  );

  /// Convert temperature to Celsius
  double? get celsius => kelvin != null ? kelvin! - 273.15 : null;

  /// Convert temperature to Fahrenheit
  double? get fahrenheit => kelvin != null ? kelvin! * (9 / 5) - 459.67 : null;
}
