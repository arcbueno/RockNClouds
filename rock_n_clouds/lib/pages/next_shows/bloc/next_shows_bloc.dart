import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/pages/next_shows/bloc/next_shows_state.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/services/weather_service.dart';
import 'package:rock_n_clouds/utils/string_extensions.dart';

class NextShowsBloc extends Cubit<NextShowsState> {
  final WeatherService _weatherService;
  static const concertCities = [
    'Silverstone, GB',
    'São Paulo, BR',
    'Melbourne, AU',
    'Monte Carlo, MC'
  ];
  final Map<String, List<WeatherDomain>> weatherData =
      <String, List<WeatherDomain>>{};
  NextShowsBloc([WeatherService? weatherService])
      : _weatherService = weatherService ?? getIt.get<WeatherService>(),
        super(NextShowsState(weatherList: {}, isLoading: true)) {
    onInit();
  }

  onInit() {
    getConcertsWeather();
  }

  void getConcertsWeather() {
    emit(state.copyWith(isLoading: true));

    _weatherService.getAllWeatherByCitiesNames(concertCities).then(
          (result) => result.fold(
            (success) {
              weatherData.clear();
              weatherData.addAll(success);
              emit(state.copyWith(
                  weatherList: success, isLoading: false, isSerching: false));
            },
            (error) {
              emit(state.copyWith(isLoading: false, error: error.toString()));
            },
          ),
        );
  }

  submitSearch(String text) {
    if (text.isEmpty) {
      getConcertsWeather();
      return;
    }
    Map<String, List<WeatherDomain>> newWeatherData = {};
    var cities = concertCities
        .where((element) => element
            .normalized()
            .toUpperCase()
            .contains(text.normalized().toUpperCase()))
        .toList();

    for (var city in cities) {
      newWeatherData[city] = weatherData[city]!;
    }
    emit(state.copyWith(weatherList: newWeatherData, isSerching: true));
  }
}
