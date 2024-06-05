import 'package:rock_n_clouds/database/favorite_city_dao.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/service_locator.dart';

class FavoriteCityRepository {
  final FavoriteCityDao _dao;

  FavoriteCityRepository([FavoriteCityDao? dao]) : _dao = dao ?? getIt.get();

  Future<void> addFavoriteCity(FavoriteCity city) async {
    await _dao.addFavoriteCity(city);
  }

  Future<void> removeFavoriteCity(FavoriteCity city) async {
    await _dao.deleteFavoriteCity(city);
  }

  List<FavoriteCity> getFavoriteCities() {
    return _dao.getAllFavoriteCities();
  }
}
