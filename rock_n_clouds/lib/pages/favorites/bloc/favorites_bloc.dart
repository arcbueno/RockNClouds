import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/pages/favorites/bloc/favorites_state.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/favorite_city_service.dart';
import 'package:rock_n_clouds/services/weather_service.dart';

class FavoritesBloc extends Cubit<FavoritesState> {
  final FavoriteCityService _favoriteCityService;
  final WeatherService _weatherService;
  FavoritesBloc(
      [FavoriteCityService? favoriteCityService,
      WeatherService? weatherService])
      : _favoriteCityService =
            favoriteCityService ?? getIt.get<FavoriteCityService>(),
        _weatherService = weatherService ?? getIt.get<WeatherService>(),
        super(FavoritesState()) {
    onInit();
  }

  void onInit() {
    getFavorites();
  }

  void getFavorites() {
    emit(state.copyWith(isLoading: true));
    var result = _favoriteCityService.getAll();
    result.fold((success) {
      emit(state.copyWith(favorites: success, isLoading: false));
      getWeather(success);
    }, (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }

  Future<void> getWeather(List<FavoriteCity> cities) async {
    emit(state.copyWith(isLoading: true));

    var result = await _weatherService.getAllWeatherByFavoriteCities(cities);
    result.fold((success) {
      emit(state.copyWith(weatherList: success, isLoading: false));
    }, (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }

  Future<void> onRemoveFavorite(FavoriteCity city) async {
    emit(state.copyWith(isLoading: true));
    var result = await _favoriteCityService.delete(city);
    result.fold((success) {
      state.favorites.remove(city);
      state.weatherList.remove(city);
      emit(state.copyWith(isLoading: false));
    }, (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}
