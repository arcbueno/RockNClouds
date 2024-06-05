import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';
import 'package:rock_n_clouds/pages/home/bloc/home_bloc.dart';
import 'package:rock_n_clouds/pages/home/bloc/home_state.dart';
import 'package:rock_n_clouds/widgets/custom_bottom_navigator.dart';
import 'package:rock_n_clouds/widgets/custom_form_field.dart';
import 'package:rock_n_clouds/widgets/weather_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomBottomNavigator(
            currentRoute: BottomNavigatorRoutes.home,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        label: TextData.searchByCity,
                        controller: searchController,
                        onSubmit: () {
                          bloc.getWeatherByCityName(searchController.text);
                        },
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Theme.of(context).colorScheme.error,
                        title: Text(
                          state.error!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 20),
                        ),
                      ),
                    )),
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
