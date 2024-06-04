import 'package:hive/hive.dart';
import 'package:rock_n_clouds/models/weather_adapter.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:weather/weather.dart';

class WeatherDao {
  final BoxCollection _hive;
  late final CollectionBox<Weather> _box;

  WeatherDao([BoxCollection? hive])
      : _hive = hive ?? getIt.get<BoxCollection>() {
    Hive.registerAdapter(WeatherAdapter());
    _hive
        .openBox<Weather>(Constants.weatherBoxName)
        .then((value) => _box = value);
  }

  Future<Weather> getCurrentWeather(double lat, double lon) async {
    var list = (await _box.getAllValues()).values;
    return list.firstWhere(
        (element) => element.latitude == lat && element.longitude == lon);
  }

  Future<Weather> getWeatherByCity(String cityName) async {
    var list = (await _box.getAllValues()).values;
    return list.firstWhere((element) => element.areaName == cityName);
  }

  Future<List<Weather>> getFiveDaysWeather(double lat, double lon) async {
    var list = (await _box.getAllValues()).values;
    return list
        .where((element) => element.latitude == lat && element.longitude == lon)
        .toList();
  }

  Future<List<Weather>> getFiveDaysWeatherByCity(String cityName) async {
    var list = (await _box.getAllValues()).values;
    return list.where((element) => element.areaName == cityName).toList();
  }

  Future<void> addWeather(Weather weather) async {
    await _box.put(
        '${weather.date}-${weather.latitude}-${weather.longitude}', weather);
  }

  Future<void> addWeatherList(List<Weather> list) async {
    await _hive.transaction(
      () async {
        for (var weather in list) {
          await _box.put(
            '${weather.date}-${weather.latitude}-${weather.longitude}',
            weather,
          );
        }
      },
      boxNames: [
        Constants.weatherBoxName
      ], // By default all boxes become blocked.
      readOnly: false,
    );
  }
}
