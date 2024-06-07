import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/exceptions/empty_search_exception.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:rock_n_clouds/utils/string_extensions.dart';
import 'package:weather/weather.dart';

class WeatherDao {
  late final Box<WeatherDomain> _box;

  WeatherDao() : _box = Hive.box<WeatherDomain>(Constants.weatherBoxName);

  /// Get current weather by latitude and longitude
  WeatherDomain getCurrentWeather(double lat, double lon) {
    return _box.values.lastWhere((element) =>
        // Limit precision to simplify the query
        element.latitude?.toStringAsPrecision(3) ==
            lat.toStringAsPrecision(3) &&
        element.longitude?.toStringAsPrecision(3) ==
            lon.toStringAsPrecision(3));
  }

  /// Get weather by city name or city and country
  WeatherDomain getWeatherByCity(String cityName) {
    if (cityName.contains(',')) {
      var data = cityName.split(',');
      var city = data[0].trim();
      var country = data[1].trim();

      if (city.isEmpty || country.isEmpty) throw EmptySearchException();
      return _getWeatherByCityAndCountry(city, country);
    }
    return _box.values.lastWhere((element) =>
        (element.areaName ?? '').normalized().toUpperCase() ==
        (cityName).normalized().toUpperCase());
  }

  /// Get weather by city name and country
  WeatherDomain _getWeatherByCityAndCountry(String cityName, String country) {
    return _box.values.lastWhere((element) =>
        (element.areaName ?? '').normalized().toUpperCase() ==
            (cityName).normalized().toUpperCase() &&
        (country).normalized().toUpperCase() ==
            (element.country ?? '').normalized().toUpperCase());
  }

  /// Get next five days weather by latitude and longitude
  List<WeatherDomain> getFiveDaysWeather(double lat, double lon) {
    final finalValues = <WeatherDomain>[];
    final storagedValues = _box.values
        .where((element) =>
            // Limit precision to simplify the query
            element.latitude?.toStringAsPrecision(3) ==
                lat.toStringAsPrecision(3) &&
            element.longitude?.toStringAsPrecision(3) ==
                lon.toStringAsPrecision(3) &&
            element.date != null &&
            element.date!.isAfter(DateTime.now()))
        .toList();

    finalValues.addAll(_filterFiveDaysWeather(storagedValues));
    return finalValues;
  }

  /// Get next five days weather by city
  List<WeatherDomain> getFiveDaysWeatherByCity(String cityName) {
    final finalValues = <WeatherDomain>[];
    if (cityName.contains(',')) {
      var data = cityName.split(',');
      var city = data[0].trim();
      var country = data[1].trim();
      if (city.isEmpty || country.isEmpty) throw EmptySearchException();
      final fiveDaysWeather =
          _getFiveDaysWeatherByCityAndCountry(city, country);
      finalValues.addAll(_filterFiveDaysWeather(fiveDaysWeather));
      return finalValues;
    }
    final storagedValues = _box.values
        .where((element) =>
            (element.areaName ?? '').normalized().toUpperCase() ==
            cityName.normalized().toUpperCase())
        .toList();

    finalValues.addAll(_filterFiveDaysWeather(storagedValues));
    return finalValues;
  }

  /// Get next five days weather by city and country
  List<WeatherDomain> _getFiveDaysWeatherByCityAndCountry(
      String cityName, String country) {
    final finalValues = <WeatherDomain>[];
    var storagedValues = _box.values
        .where((element) =>
            (element.areaName ?? '').normalized().toUpperCase() ==
                (cityName).normalized().toUpperCase() &&
            (country).normalized().toUpperCase() ==
                (element.country ?? '').normalized().toUpperCase())
        .toList();

    finalValues.addAll(_filterFiveDaysWeather(storagedValues));
    return finalValues;
  }

  /// Filter the days to get a medium temperature skipping the first day found
  List<WeatherDomain> _filterFiveDaysWeather(
      List<WeatherDomain> storagedValues) {
    final finalValues = <WeatherDomain>[];
    for (var day in storagedValues.skip(1)) {
      // The first day is skipped because it's already shown for the user
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
      await _box.deleteAll(existendList.map((e) => e.key).toList());
    }
    await _box.add(weatherDomain);
  }

  Future<void> addWeatherList(List<Weather> list) async {
    await Future.forEach(list, (element) async {
      // Use the addWeather() for reuse the login inside it
      await addWeather(element);
    });
  }
}
