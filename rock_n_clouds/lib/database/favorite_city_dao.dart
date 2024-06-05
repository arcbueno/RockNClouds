import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/utils/constants.dart';

class FavoriteCityDao {
  late final Box<FavoriteCity> _box;

  FavoriteCityDao()
      : _box = Hive.box<FavoriteCity>(Constants.favoriteCityBoxName);

  List<FavoriteCity> getAllFavoriteCities() {
    return _box.values.toList();
  }

  Future<void> addFavoriteCity(FavoriteCity favoriteCity) async {
    await _box.add(favoriteCity);
  }

  Future<void> deleteFavoriteCity(FavoriteCity favoriteCity) async {
    await _box.delete(favoriteCity);
  }
}
