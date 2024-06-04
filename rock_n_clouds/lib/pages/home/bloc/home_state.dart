class HomeState {
  final bool isLoading;
  final String? error;

  HomeState({required this.isLoading, this.error});

  HomeState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
