import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';
import 'package:rock_n_clouds/pages/next_shows/bloc/next_shows_bloc.dart';
import 'package:rock_n_clouds/pages/next_shows/bloc/next_shows_state.dart';
import 'package:rock_n_clouds/widgets/custom_bottom_navigator.dart';
import 'package:rock_n_clouds/widgets/search_field.dart';
import 'package:rock_n_clouds/widgets/show_error_widget.dart';
import 'package:rock_n_clouds/widgets/weather_list_tile.dart';

class NextShowsPage extends StatefulWidget {
  const NextShowsPage({super.key});

  @override
  State<NextShowsPage> createState() => _NextShowsPageState();
}

class _NextShowsPageState extends State<NextShowsPage> {
  late final NextShowsBloc bloc;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc = NextShowsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NextShowsBloc, NextShowsState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomBottomNavigator(
            currentRoute: BottomNavigatorRoutes.nextShows,
          ),
          appBar: AppBar(
            title: const Text(TextData.rocNClouds),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchField(
                        searchController: searchController,
                        onSubmit: () =>
                            bloc.submitSearch(searchController.text),
                      ),
                      if (state.weatherList.isNotEmpty)
                        ...state.weatherList.keys.map(
                          (e) => ExpansionTile(
                            key: ObjectKey(DateTime.now()),
                            initiallyExpanded: state.isSerching,
                            title: Row(
                              children: [
                                const Icon(Icons.location_on),
                                Text(e),
                              ],
                            ),
                            children: state.weatherList[e]!
                                .map(
                                  (weather) =>
                                      WeatherListTile(weather: weather),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (state.error != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ShowErrorWidget(error: state.error!),
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
