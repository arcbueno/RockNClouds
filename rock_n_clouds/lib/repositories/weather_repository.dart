import 'package:rock_n_clouds/database/weather_dao.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/network_service.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  final WeatherFactory _weatherApi;
  final WeatherDao _weatherDao;
  final NetworkService _networkService;

  WeatherRepository(
      [WeatherFactory? weatherFactory,
      WeatherDao? weatherDao,
      NetworkService? networkService])
      : _weatherApi = weatherFactory ?? getIt.get<WeatherFactory>(),
        _weatherDao = weatherDao ?? getIt.get<WeatherDao>(),
        _networkService = networkService ?? getIt.get<NetworkService>();

  Future<WeatherDomain> getCurrentWeather(double lat, double lon) async {
    var isOnline = await _networkService.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.currentWeatherByLocation(lat, lon);
      return await _weatherDao
          .addWeather(WeatherDomain.fromWeather(onlineData))
          .then((value) async => _weatherDao.getCurrentWeather(lat, lon));
    }
    return _weatherDao.getCurrentWeather(lat, lon);
  }

  Future<WeatherDomain> getWeatherByCity(String cityName) async {
    var isOnline = await _networkService.isOnline();
    if (isOnline) {
      // Fetch online data
      var onlineData = await _weatherApi.currentWeatherByCityName(cityName);
      // Insert data locally
      await _weatherDao.addWeather(WeatherDomain.fromWeather(onlineData));
      // Retrieve from local DB
      return _weatherDao.getWeatherByCity(cityName);
    }
    return _weatherDao.getWeatherByCity(cityName);
  }

  Future<List<WeatherDomain>> getFiveDaysWeather(double lat, double lon) async {
    var isOnline = await _networkService.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByLocation(lat, lon);
      await _weatherDao.addWeatherList(
          onlineData.map((e) => WeatherDomain.fromWeather(e)).toList());
      return _weatherDao.getFiveDaysWeather(lat, lon);
    }
    return _weatherDao.getFiveDaysWeather(lat, lon);
  }

  Future<List<WeatherDomain>> getFiveDaysWeatherByCity(String cityName) async {
    var isOnline = await _networkService.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByCityName(cityName);
      await _weatherDao.addWeatherList(
          onlineData.map((e) => WeatherDomain.fromWeather(e)).toList());
      return _weatherDao.getFiveDaysWeatherByCity(cityName);
    }
    return _weatherDao.getFiveDaysWeatherByCity(cityName);
  }

  Future<List<WeatherDomain>> getAllWeatherByCity(String cityName) async {
    // Gets the 6 days weather (current day + next five days)
    final weatherList = <WeatherDomain>[];
    var currentWeather = await getWeatherByCity(cityName);
    var nextFiveDays = await getFiveDaysWeatherByCity(cityName);
    weatherList.add(currentWeather);
    weatherList.addAll(nextFiveDays);
    return weatherList;
  }
}
