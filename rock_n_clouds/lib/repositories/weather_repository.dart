import 'package:rock_n_clouds/database/weather_dao.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/utils/network_utils.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  final WeatherFactory _weatherApi;
  final WeatherDao _weatherDao;

  WeatherRepository([WeatherFactory? weatherFactory, WeatherDao? weatherDao])
      : _weatherApi = weatherFactory ?? getIt.get<WeatherFactory>(),
        _weatherDao = weatherDao ?? getIt.get<WeatherDao>();

  Future<Weather> getCurrentWeather(double lat, double lon) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.currentWeatherByLocation(lat, lon);
      await _weatherDao.addWeather(onlineData);
      return _weatherDao.getCurrentWeather(lat, lon);
    }
    return _weatherDao.getCurrentWeather(lat, lon);
  }

  Future<Weather> getWeatherByCity(String cityName) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.currentWeatherByCityName(cityName);
      await _weatherDao.addWeather(onlineData);
      return _weatherDao.getWeatherByCity(cityName);
    }
    return _weatherDao.getWeatherByCity(cityName);
  }

  Future<List<Weather>> getFiveDaysWeather(double lat, double lon) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByLocation(lat, lon);
      await _weatherDao.addWeatherList(onlineData);
      return _weatherDao.getFiveDaysWeather(lat, lon);
    }
    return _weatherDao.getFiveDaysWeather(lat, lon);
  }

  Future<List<Weather>> getFiveDaysWeatherByCity(String cityName) async {
    var isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      var onlineData = await _weatherApi.fiveDayForecastByCityName(cityName);
      await _weatherDao.addWeatherList(onlineData);
      return _weatherDao.getFiveDaysWeatherByCity(cityName);
    }
    return _weatherDao.getFiveDaysWeatherByCity(cityName);
  }
}
