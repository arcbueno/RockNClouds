import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';

class FavoritesState {
  final List<FavoriteCity> favorites;
  final bool isLoading;
  final String? error;
  final Map<FavoriteCity, List<WeatherDomain>> weatherList;
  FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
    this.weatherList = const {},
  });

  FavoritesState copyWith({
    List<FavoriteCity>? favorites,
    bool? isLoading,
    String? error,
    Map<FavoriteCity, List<WeatherDomain>>? weatherList,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      weatherList: weatherList ?? this.weatherList,
    );
  }
}
