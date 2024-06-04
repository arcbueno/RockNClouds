import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:weather/weather.dart';

class WeatherDao {
  late final Box<WeatherDomain> _box;

  WeatherDao() {
    if (!Hive.isAdapterRegistered(WeatherDomainAdapter().typeId)) {
      Hive.registerAdapter<WeatherDomain>(WeatherDomainAdapter());
    }
    if (!Hive.isAdapterRegistered(TemperatureDomainAdapter().typeId)) {
      Hive.registerAdapter<TemperatureDomain>(TemperatureDomainAdapter());
    }
    Hive.openBox<WeatherDomain>(Constants.weatherBoxName).then(
        (value) => _box = Hive.box<WeatherDomain>(Constants.weatherBoxName));
  }

  WeatherDomain getCurrentWeather(double lat, double lon) {
    return _box.values.lastWhere((element) =>
        element.latitude?.toStringAsPrecision(3) ==
            lat.toStringAsPrecision(3) &&
        element.longitude?.toStringAsPrecision(3) ==
            lon.toStringAsPrecision(3));
  }

  WeatherDomain getWeatherByCity(String cityName) {
    return _box.values.firstWhere((element) => element.areaName == cityName);
  }

  List<WeatherDomain> getFiveDaysWeather(double lat, double lon) {
    return _box.values
        .where((element) => element.latitude == lat && element.longitude == lon)
        .toList();
  }

  List<WeatherDomain> getFiveDaysWeatherByCity(String cityName) {
    return _box.values
        .where((element) => element.areaName == cityName)
        .toList();
  }

  Future<void> addWeather(Weather weather) async {
    await _box.add(
      WeatherDomain.fromWeather(weather),
    );
  }

  Future<void> addWeatherList(List<Weather> list) async {
    await _box.addAll(list.map((e) => WeatherDomain.fromWeather(e)).toList());

    // await _hive.transaction(
    //   () async {
    //     for (var weather in list) {
    //       await _box.put(
    //         '${weather.date}-${weather.latitude}-${weather.longitude}',
    //         weather,
    //       );
    //     }
    //   },
    //   boxNames: [
    //     Constants.weatherBoxName
    //   ], // By default all boxes become blocked.
    //   readOnly: false,
    // );
  }
}
