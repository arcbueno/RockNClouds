import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/pages/home/bloc/home_state.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/favorite_city_service.dart';
import 'package:rock_n_clouds/services/geolocation_service.dart';
import 'package:rock_n_clouds/services/weather_service.dart';
import 'package:string_normalizer/string_normalizer.dart';

class HomeBloc extends Cubit<HomeState> {
  final WeatherService _weatherService;
  final GeolocationService _geolocationService;
  final FavoriteCityService _favoriteCityService;

  HomeBloc(
      [WeatherService? weatherService,
      GeolocationService? geolocationService,
      FavoriteCityService? favoriteCityService])
      : _weatherService = weatherService ?? getIt.get<WeatherService>(),
        _geolocationService =
            geolocationService ?? getIt.get<GeolocationService>(),
        _favoriteCityService =
            favoriteCityService ?? getIt.get<FavoriteCityService>(),
        super(HomeState(isLoading: false)) {
    onInit();
  }

  void onInit() {
    getAllFavorites();
    fetchCurrentWeather();
  }

  void getAllFavorites() {
    emit(state.copyWith(isLoading: true));
    var result = _favoriteCityService.getAll();
    result.fold(
      (success) => emit(state.copyWith(isLoading: false, favorites: success)),
      (failure) => emit(
        state.copyWith(isLoading: false, error: failure.toString()),
      ),
    );
  }

  Future<void> fetchCurrentWeather() async {
    emit(state.copyWith(isLoading: true));
    (double lat, double long) coordinates = (0, 0);
    var result = await _geolocationService.getCurrentLocation();
    result.fold(
      (success) => coordinates = success,
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          error: failure.toString(),
        ),
      ),
    );

    if (state.isError) return;

    return _getWeatherByCoordinates(coordinates.$1, coordinates.$2);
  }

  void verifyCurrentCityIsFavorite() {
    var isFavorite = state.favorites
        .where((element) =>
            StringNormalizer.normalize(element.areaName ?? '') ==
            StringNormalizer.normalize(state.currentWeather?.areaName ?? ''))
        .isNotEmpty;
    emit(state.copyWith(isCityAsFavorite: isFavorite));
  }

  Future<void> _getWeatherByCoordinates(double lat, double long) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getCurrentWeather(lat, long);
    return result.fold((success) {
      emit(state.copyWithouErrors(
        isLoading: false,
        currentWeather: success,
        isCitySearch: false,
      ));
      verifyCurrentCityIsFavorite();
      _getFiveDaysWeatherByCoordinates(lat, long);
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> _getFiveDaysWeatherByCoordinates(double lat, double long) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getFiveDaysWeather(lat, long);
    return result.fold((success) {
      emit(state.copyWithouErrors(
        isLoading: false,
        nextFiveDaysWeather: success,
        isCitySearch: false,
      ));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> getWeatherByCityName(String name) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getWeatherByCity(name);
    return result.fold((success) {
      emit(state.copyWithouErrors(
        isLoading: false,
        currentWeather: success,
        isCitySearch: true,
        cityName: name,
      ));
      verifyCurrentCityIsFavorite();
      _getFiveDaysWeatherByCityName(name);
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> _getFiveDaysWeatherByCityName(String name) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getFiveDaysWeatherByCity(name);
    return result.fold((success) {
      emit(state.copyWithouErrors(
        isLoading: false,
        nextFiveDaysWeather: success,
        isCitySearch: true,
        cityName: name,
      ));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> removeCityFromFavorites() async {
    emit(state.copyWith(isLoading: true));
    var favoriteData = state.favorites
        .where((element) => element.areaName == state.currentWeather?.areaName)
        .first;
    var result = await _favoriteCityService.delete(favoriteData);
    return result.fold((success) {
      emit(state.copyWithouErrors(isLoading: false, isCityAsFavorite: false));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> addCurrentCityAsFavorite() async {
    emit(state.copyWith(isLoading: true));
    var favorite = FavoriteCity(
      areaName: state.currentWeather?.areaName,
      lat: state.currentWeather?.latitude,
      lon: state.currentWeather?.longitude,
      country: state.currentWeather?.country,
    );
    var result = await _favoriteCityService.add(favorite);
    return result.fold((success) {
      emit(state.copyWith(isLoading: false, isCityAsFavorite: true));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }
}
