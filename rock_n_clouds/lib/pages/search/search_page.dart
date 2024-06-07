import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';
import 'package:rock_n_clouds/pages/search/bloc/search_bloc.dart';
import 'package:rock_n_clouds/pages/search/bloc/search_state.dart';
import 'package:rock_n_clouds/widgets/custom_bottom_navigator.dart';
import 'package:rock_n_clouds/widgets/search_field.dart';
import 'package:rock_n_clouds/widgets/show_error_widget.dart';
import 'package:rock_n_clouds/widgets/weather_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchBloc bloc;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc = SearchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomBottomNavigator(
            currentRoute: BottomNavigatorRoutes.search,
          ),
          appBar: AppBar(
            title: const Text(TextData.search),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchField(
                        searchController: searchController,
                        onSubmit: () =>
                            bloc.getWeatherByCityName(searchController.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.isCitySearch
                                  ? (state.currentWeather?.areaName ??
                                      TextData.currentWeather)
                                  : TextData.currentWeather,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                state.isCityAsFavorite
                                    ? bloc.removeCityFromFavorites()
                                    : bloc.addCurrentCityAsFavorite();
                              },
                              icon: Icon(
                                state.isCityAsFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                              ),
                            )
                          ],
                        ),
                      ),
                      if (state.currentWeather != null)
                        WeatherListTile(
                          weather: state.currentWeather!,
                        ),
                      if (state.nextFiveDaysWeather.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  TextData.nextFiveDays,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ...state.nextFiveDaysWeather
                                  .map((e) => WeatherListTile(weather: e)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (state.isError)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ShowErrorWidget(
                    error: state.error!,
                  ),
                ),
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
