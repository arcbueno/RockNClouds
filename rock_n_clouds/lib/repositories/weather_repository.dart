import 'package:rock_n_clouds/database/weather_dao.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/utils/network_utils.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  final WeatherFactory _weatherApi;
  final WeatherDao _weatherDao;

  WeatherRepository([WeatherFactory? weatherFactory, WeatherDao? weatherDao])
      : _weatherApi = weatherFactory ?? getIt.get<WeatherFactory>(),
        _weatherDao = weatherDao ?? getIt.get<WeatherDao>();

  Future<WeatherDomain> getCurrentWeather(double lat, double lon) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.currentWeatherByLocation(lat, lon);
      await _weatherDao.addWeather(WeatherDomain.fromWeather(onlineData));
      return _weatherDao.getCurrentWeather(lat, lon);
    }
    return _weatherDao.getCurrentWeather(lat, lon);
  }

  Future<WeatherDomain> getWeatherByCity(String cityName) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.currentWeatherByCityName(cityName);
      await _weatherDao.addWeather(WeatherDomain.fromWeather(onlineData));
      return _weatherDao.getWeatherByCity(cityName);
    }
    return _weatherDao.getWeatherByCity(cityName);
  }

  Future<List<WeatherDomain>> getFiveDaysWeather(double lat, double lon) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByLocation(lat, lon);
      await _weatherDao.addWeatherList(
          onlineData.map((e) => WeatherDomain.fromWeather(e)).toList());
      return _weatherDao.getFiveDaysWeather(lat, lon);
    }
    return _weatherDao.getFiveDaysWeather(lat, lon);
  }

  Future<List<WeatherDomain>> getFiveDaysWeatherByCity(String cityName) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByCityName(cityName);
      await _weatherDao.addWeatherList(
          onlineData.map((e) => WeatherDomain.fromWeather(e)).toList());
      return _weatherDao.getFiveDaysWeatherByCity(cityName);
    }
    return _weatherDao.getFiveDaysWeatherByCity(cityName);
  }

  Future<List<WeatherDomain>> getAllWeatherByCity(String cityName) async {
    final weatherList = <WeatherDomain>[];
    var currentWeather = await getWeatherByCity(cityName);
    var nextFiveDays = await getFiveDaysWeatherByCity(cityName);
    weatherList.add(currentWeather);
    weatherList.addAll(nextFiveDays);
    return weatherList;
  }
}
