import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_clouds/database/weather_dao.dart';
import 'package:rock_n_clouds/repositories/weather_repository.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:weather/weather.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup(BoxCollection hive) {
    getIt.registerSingleton<BoxCollection>(hive);
    getIt.registerSingleton(
        WeatherFactory(Constants.apiKey, language: Language.ENGLISH));
    getIt.registerSingleton<WeatherDao>(WeatherDao());
    getIt.registerSingleton<WeatherRepository>(WeatherRepository());
  }
}
