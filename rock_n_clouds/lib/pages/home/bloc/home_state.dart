import 'package:weather/weather.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final Weather? currentWeather;

  bool get isError => error != null;

  HomeState({required this.isLoading, this.error, this.currentWeather});

  HomeState copyWith({
    bool? isLoading,
    String? error,
    Weather? currentWeather,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentWeather: currentWeather ?? this.currentWeather,
    );
  }
}
