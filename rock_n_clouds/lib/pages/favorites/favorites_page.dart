import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';
import 'package:rock_n_clouds/pages/favorites/bloc/favorites_bloc.dart';
import 'package:rock_n_clouds/pages/favorites/bloc/favorites_state.dart';
import 'package:rock_n_clouds/widgets/custom_bottom_navigator.dart';
import 'package:rock_n_clouds/widgets/weather_list_tile.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesBloc bloc;

  @override
  void initState() {
    bloc = FavoritesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextData.favorites),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              (state.weatherList.values.isEmpty && !state.isLoading)
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border, size: 100),
                          Text(
                            'No favorites set yet',
                            style: TextStyle(fontSize: 42),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...state.weatherList.keys.map(
                            (e) => ExpansionTile(
                              title: Row(
                                children: [
                                  const Icon(Icons.location_city),
                                  Text(e.areaName ?? ''),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      bloc.onRemoveFavorite(e);
                                    },
                                    icon: const Icon(Icons.star),
                                  ),
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
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigator(
        currentRoute: BottomNavigatorRoutes.favorites,
      ),
    );
  }
}
