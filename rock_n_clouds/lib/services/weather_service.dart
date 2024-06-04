import 'package:result_dart/result_dart.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/repositories/weather_repository.dart';
import 'package:rock_n_clouds/service_locator.dart';

class WeatherService {
  final WeatherRepository _repository;

  WeatherService([WeatherRepository? repository])
      : _repository = repository ?? getIt.get<WeatherRepository>();

  Future<Result<WeatherDomain, Exception>> getCurrentWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getCurrentWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<WeatherDomain, Exception>> getWeatherByCity(
      String cityName) async {
    try {
      var result = await _repository.getWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<List<WeatherDomain>, Exception>> getFiveDaysWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getFiveDaysWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<List<WeatherDomain>, Exception>> getFiveDaysWeatherByCity(
      String cityName) async {
    try {
      var result = await _repository.getFiveDaysWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
