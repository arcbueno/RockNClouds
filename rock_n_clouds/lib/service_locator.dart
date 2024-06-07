import 'package:get_it/get_it.dart';
import 'package:rock_n_clouds/database/favorite_city_dao.dart';
import 'package:rock_n_clouds/database/weather_dao.dart';
import 'package:rock_n_clouds/repositories/favorite_city_repository.dart';
import 'package:rock_n_clouds/repositories/weather_repository.dart';
import 'package:rock_n_clouds/services/favorite_city_service.dart';
import 'package:rock_n_clouds/services/geolocation_service.dart';
import 'package:rock_n_clouds/services/weather_service.dart';
import 'package:rock_n_clouds/utils/constants.dart';
import 'package:weather/weather.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerSingleton(
        WeatherFactory(Constants.apiKey, language: Language.PORTUGUESE_BRAZIL));
    getIt.registerSingleton<WeatherDao>(WeatherDao());
    getIt.registerSingleton<FavoriteCityDao>(FavoriteCityDao());

    getIt.registerSingleton<WeatherRepository>(WeatherRepository());
    getIt.registerSingleton<WeatherService>(WeatherService());
    getIt.registerSingleton<GeolocationService>(GeolocationService());

    getIt.registerSingleton<FavoriteCityRepository>(FavoriteCityRepository());
    getIt.registerSingleton<FavoriteCityService>(FavoriteCityService());
  }
}
