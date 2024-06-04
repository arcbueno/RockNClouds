import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final WeatherDomain? currentWeather;

  bool get isError => error != null;

  HomeState({required this.isLoading, this.error, this.currentWeather});

  HomeState copyWith({
    bool? isLoading,
    String? error,
    WeatherDomain? currentWeather,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentWeather: currentWeather ?? this.currentWeather,
    );
  }
}
