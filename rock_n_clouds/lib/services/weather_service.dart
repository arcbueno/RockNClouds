import 'package:result_dart/result_dart.dart';
import 'package:rock_n_clouds/exceptions/city_not_found_exception.dart';
import 'package:rock_n_clouds/exceptions/network_connection_failed.dart';
import 'package:rock_n_clouds/exceptions/server_error_exception.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/repositories/weather_repository.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/network_service.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final WeatherRepository _repository;
  final NetworkService _networkService;

  WeatherService(
      [WeatherRepository? repository, NetworkService? networkService])
      : _repository = repository ?? getIt.get<WeatherRepository>(),
        _networkService = networkService ?? getIt.get<NetworkService>();

  Future<Result<WeatherDomain, Exception>> getCurrentWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getCurrentWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Result<WeatherDomain, Exception>> getWeatherByCity(
      String cityName) async {
    try {
      var result = await _repository.getWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Result<List<WeatherDomain>, Exception>> getFiveDaysWeather(
      double lat, double lon) async {
    try {
      var result = await _repository.getFiveDaysWeather(lat, lon);
      return Result.success(result);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Result<List<WeatherDomain>, Exception>> getFiveDaysWeatherByCity(
      String cityName) async {
    try {
      var result = await _repository.getFiveDaysWeatherByCity(cityName);
      return Result.success(result);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Result<Map<FavoriteCity, List<WeatherDomain>>, Exception>>
      getAllWeatherByFavoriteCities(List<FavoriteCity> cities) async {
    try {
      Map<FavoriteCity, List<WeatherDomain>> finalResult = {};
      for (var city in cities) {
        var weatherList = await _repository.getAllWeatherByCity(city.areaName!);
        finalResult[city] = weatherList;
      }
      return Result.success(finalResult);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Result<Map<String, List<WeatherDomain>>, Exception>>
      getAllWeatherByCitiesNames(List<String> cities) async {
    try {
      Map<String, List<WeatherDomain>> finalResult = {};
      for (var city in cities) {
        var weatherList = await _repository.getAllWeatherByCity(city);
        finalResult[city] = weatherList;
      }
      return Result.success(finalResult);
    } catch (e) {
      return (await _errorHandler(e)).toFailure();
    }
  }

  Future<Exception> _errorHandler(dynamic e) async {
    // Consider every error offine a network error
    if (!await _networkService.isOnline()) {
      return NetworkConnectionFailed();
    }
    if (e is OpenWeatherAPIException) {
      if (e.toString().contains('"cod":"404"')) {
        return CityNotFoundException();
      }
      if (e.toString().contains('"cod":"500"')) {
        return ServerErrorException();
      }
      // Add more verifications later
    }
    return Exception(e.toString());
  }
}
