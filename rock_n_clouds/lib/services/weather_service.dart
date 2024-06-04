import 'package:result_dart/result_dart.dart';
import 'package:rock_n_clouds/exceptions/unexpected_error.dart';
import 'package:rock_n_clouds/repositories/weather_repository.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final WeatherRepository _repository;

  WeatherService([WeatherRepository? repository])
      : _repository = repository ?? getIt.get<WeatherRepository>();

  Future<Result<Weather, Exception>> getCurrentWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getCurrentWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return _errorHandler(e) as Failure<Weather, Exception>;
    }
  }

  Future<Result<Weather, Exception>> getWeatherByCity(String cityName) async {
    try {
      var result = await _repository.getWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return _errorHandler(e) as Failure<Weather, Exception>;
    }
  }

  Future<Result<List<Weather>, Exception>> getFiveDaysWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getFiveDaysWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return _errorHandler(e) as Failure<List<Weather>, Exception>;
    }
  }

  Future<Result<List<Weather>, Exception>> getFiveDaysWeatherByCity(
      String cityName) async {
    try {
      var result = await _repository.getFiveDaysWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return _errorHandler(e) as Failure<List<Weather>, Exception>;
    }
  }

  Failure _errorHandler(dynamic error) {
    if (error is Exception) {
      return Failure(error);
    }
    return Failure(UnexpectedError());
  }
}
