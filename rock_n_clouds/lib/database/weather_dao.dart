import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:rock_n_clouds/utils/string_extensions.dart';
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
    if (cityName.contains(',')) {
      var data = cityName.split(',');
      cityName = data[0].trim();
      var countryName = data[1].trim();
      return getWeatherByCityAndCountry(cityName, countryName);
    }
    return _box.values.firstWhere((element) =>
        (element.areaName ?? '').normalized().toUpperCase() ==
        (cityName).normalized().toUpperCase());
  }

  WeatherDomain getWeatherByCityAndCountry(String cityName, String country) {
    return _box.values.firstWhere((element) =>
        (element.areaName ?? '').normalized().toUpperCase() ==
            (cityName).normalized().toUpperCase() &&
        (country).normalized().toUpperCase() ==
            (element.country ?? '').normalized().toUpperCase());
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

    finalValues.addAll(filterFiveDaysWeather(storagedValues));
    return finalValues;
  }

  List<WeatherDomain> filterFiveDaysWeather(
      List<WeatherDomain> storagedValues) {
    final finalValues = <WeatherDomain>[];
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
    if (cityName.contains(',')) {
      var data = cityName.split(',');
      cityName = data[0].trim();
      var countryName = data[1].trim();
      final fiveDaysWeather =
          getFiveDaysWeatherByCityAndCountry(cityName, countryName);
      finalValues.addAll(filterFiveDaysWeather(fiveDaysWeather));
      return finalValues;
    }
    final storagedValues = _box.values
        .where((element) =>
            (element.areaName ?? '').normalized().toUpperCase() ==
            cityName.normalized().toUpperCase())
        .toList();

    finalValues.addAll(filterFiveDaysWeather(storagedValues));
    return finalValues;
  }

  List<WeatherDomain> getFiveDaysWeatherByCityAndCountry(
      String cityName, String country) {
    return _box.values
        .where((element) =>
            (element.areaName ?? '').normalized().toUpperCase() ==
                (cityName).normalized().toUpperCase() &&
            (country).normalized().toUpperCase() ==
                (element.country ?? '').normalized().toUpperCase())
        .toList();
  }

  Future<void> addWeather(Weather weather) async {
    var weatherDomain = WeatherDomain.fromWeather(weather);
    var existendList = _box.values.where((element) =>
        ((element.areaName ?? '').normalized().toUpperCase() ==
            (weather.areaName ?? '').normalized().toUpperCase()) &&
        ((element.country ?? '').normalized().toUpperCase() ==
            (weather.country ?? '').normalized().toUpperCase()) &&
        (weather.date?.day == element.date?.day &&
            weather.date?.month == element.date?.month &&
            weather.date?.year == element.date?.year));
    if (existendList.isNotEmpty) {
      // await _box.delete(existendList.first.key);
      await _box.put(existendList.first.key, weatherDomain);
      return;
    }
    await _box.add(weatherDomain);
  }

  Future<void> addWeatherList(List<Weather> list) async {
    await Future.forEach(list, (element) async {
      await addWeather(element);
    });
  }
}
