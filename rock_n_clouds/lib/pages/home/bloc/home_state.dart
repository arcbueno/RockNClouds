import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final WeatherDomain? currentWeather;
  final List<WeatherDomain> nextFiveDaysWeather;
  final bool isCitySearch;
  final String? cityName;

  bool get isError => error != null;

  HomeState({
    required this.isLoading,
    this.error,
    this.currentWeather,
    this.nextFiveDaysWeather = const [],
    this.isCitySearch = false,
    this.cityName,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    WeatherDomain? currentWeather,
    List<WeatherDomain>? nextFiveDaysWeather,
    bool? isCitySearch,
    String? cityName,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentWeather: currentWeather ?? this.currentWeather,
      nextFiveDaysWeather: nextFiveDaysWeather ?? this.nextFiveDaysWeather,
      isCitySearch: isCitySearch ?? this.isCitySearch,
      cityName: cityName ?? this.cityName,
    );
  }
}
