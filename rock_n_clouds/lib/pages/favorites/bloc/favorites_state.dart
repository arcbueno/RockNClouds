import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';

class FavoritesState {
  final List<FavoriteCity> favorites;
  final bool isLoading;
  final String? error;
  FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
  });
}
