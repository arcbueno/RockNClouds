import 'package:result_dart/result_dart.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/repositories/favorite_city_repository.dart';
import 'package:rock_n_clouds/service_locator.dart';

class FavoriteCityService {
  final FavoriteCityRepository _repository;

  FavoriteCityService([FavoriteCityRepository? repository])
      : _repository = repository ?? getIt.get<FavoriteCityRepository>();

  Result<List<FavoriteCity>, Exception> getAll() {
    try {
      var result = _repository.getFavoriteCities();
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  Future<Result<FavoriteCity, Exception>> add(FavoriteCity favoriteCity) async {
    try {
      await _repository.addFavoriteCity(favoriteCity);
      return Success(favoriteCity);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  Future<Result<FavoriteCity, Exception>> delete(
      FavoriteCity favoriteCity) async {
    try {
      await _repository.removeFavoriteCity(favoriteCity);
      return Success(favoriteCity);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
