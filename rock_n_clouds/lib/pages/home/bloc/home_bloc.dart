import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/pages/home/bloc/home_state.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/geolocation_service.dart';
import 'package:rock_n_clouds/services/weather_service.dart';

class HomeBloc extends Cubit<HomeState> {
  final WeatherService _weatherService;
  final GeolocationService _geolocationService;
  HomeBloc(
      [WeatherService? weatherService, GeolocationService? geolocationService])
      : _weatherService = weatherService ?? getIt.get<WeatherService>(),
        _geolocationService =
            geolocationService ?? getIt.get<GeolocationService>(),
        super(HomeState(isLoading: false));

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

  Future<void> _getWeatherByCoordinates(double lat, double long) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getCurrentWeather(lat, long);
    return result.fold((success) {
      emit(state.copyWith(
        isLoading: false,
        currentWeather: success,
        isCitySearch: false,
      ));
      _getFiveDaysWeatherByCoordinates(lat, long);
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> _getFiveDaysWeatherByCoordinates(double lat, double long) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getFiveDaysWeather(lat, long);
    return result.fold((success) {
      emit(state.copyWith(
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
      emit(state.copyWith(
        isLoading: false,
        currentWeather: success,
        isCitySearch: true,
        cityName: name,
      ));
      _getFiveDaysWeatherByCityName(name);
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }

  Future<void> _getFiveDaysWeatherByCityName(String name) async {
    emit(state.copyWith(isLoading: true));
    var result = await _weatherService.getFiveDaysWeatherByCity(name);
    return result.fold((success) {
      emit(state.copyWith(
        isLoading: false,
        nextFiveDaysWeather: success,
        isCitySearch: true,
        cityName: name,
      ));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
    });
  }
}
