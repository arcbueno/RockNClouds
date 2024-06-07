import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';

class NextShowsState {
  final Map<String, List<WeatherDomain>> weatherList;
  final String? error;
  final bool isLoading;
  final bool isSerching;

  NextShowsState({
    required this.weatherList,
    this.error,
    this.isLoading = false,
    this.isSerching = false,
  });

  NextShowsState copyWith({
    Map<String, List<WeatherDomain>>? weatherList,
    String? error,
    bool? isLoading,
    bool? isSerching,
    bool? searchNotFound,
  }) {
    return NextShowsState(
      weatherList: weatherList ?? this.weatherList,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSerching: isSerching ?? this.isSerching,
    );
  }
}
