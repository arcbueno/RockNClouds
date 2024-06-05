import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:string_normalizer/string_normalizer.dart';
import 'package:weather/weather.dart';

class WeatherDao {
  late final Box<WeatherDomain> _box;

  WeatherDao() : _box = Hive.box<WeatherDomain>(Constants.weatherBoxName);

  WeatherDomain getCurrentWeather(double lat, double lon) {
    return _box.values.lastWhere((element) =>
        element.latitude?.toStringAsPrecision(3) ==
            lat.toStringAsPrecision(3) &&
        element.longitude?.toStringAsPrecision(3) ==
            lon.toStringAsPrecision(3));
  }

  WeatherDomain getWeatherByCity(String cityName) {
    return _box.values.firstWhere((element) =>
        StringNormalizer.normalize(element.areaName ?? '').toUpperCase() ==
        StringNormalizer.normalize(cityName).toUpperCase());
  }

  List<WeatherDomain> getFiveDaysWeather(double lat, double lon) {
    final finalValues = <WeatherDomain>[];
    final storagedValues = _box.values
        .where((element) =>
            element.latitude?.toStringAsPrecision(3) ==
                lat.toStringAsPrecision(3) &&
            element.longitude?.toStringAsPrecision(3) ==
                lon.toStringAsPrecision(3) &&
            element.date != null &&
            element.date!.isAfter(DateTime.now()))
        .toList();

    for (var day in storagedValues) {
      if (finalValues.length == 5) {
        break;
      }
      if (finalValues.where((e) => day.date!.day == e.date!.day).isEmpty) {
        // Get medium temperature for the day
        double mediumTemperature = 0.0;
        int totalValues = 0;
        storagedValues
            .where((element) => day.date!.day == element.date!.day)
            .forEach((e) {
          if (e.temperature?.kelvin != null &&
              day.temperature?.kelvin != null) {
            mediumTemperature += e.temperature?.kelvin ?? 0.0;
            totalValues++;
          }
          day.temperature?.kelvin = mediumTemperature / totalValues;
          totalValues = 0;
          mediumTemperature = 0.0;
        });
        finalValues.add(day);
      }
    }
    return finalValues;
  }

  List<WeatherDomain> getFiveDaysWeatherByCity(String cityName) {
    final finalValues = <WeatherDomain>[];
    final storagedValues = _box.values
        .where((element) =>
            StringNormalizer.normalize(element.areaName ?? '').toUpperCase() ==
            StringNormalizer.normalize(cityName).toUpperCase())
        .toList();

    for (var day in storagedValues) {
      if (finalValues.length == 5) {
        break;
      }
      if (finalValues.where((e) => day.date!.day == e.date!.day).isEmpty) {
        // Get medium temperature for the day
        double mediumTemperature = 0.0;
        int totalValues = 0;
        storagedValues
            .where((element) => day.date!.day == element.date!.day)
            .forEach((e) {
          if (e.temperature?.kelvin != null &&
              day.temperature?.kelvin != null) {
            mediumTemperature += e.temperature?.kelvin ?? 0.0;
            totalValues++;
          }
          day.temperature?.kelvin = mediumTemperature / totalValues;
          totalValues = 0;
          mediumTemperature = 0.0;
        });
        finalValues.add(day);
      }
    }
    return finalValues;
  }

  Future<void> addWeather(Weather weather) async {
    await _box.add(
      WeatherDomain.fromWeather(weather),
    );
  }

  Future<void> addWeatherList(List<Weather> list) async {
    await _box.addAll(list.map((e) => WeatherDomain.fromWeather(e)).toList());
  }
}
