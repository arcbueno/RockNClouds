import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rock_n_clouds/models/favorite_city/favorite_city.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/pages/favorites/favorites_page.dart';
import 'package:rock_n_clouds/pages/home/home_page.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/utils/constants.dart';

void main() async {
  await _activateHiveDatabase();
  ServiceLocator.setup();
  runApp(const MyApp());
}

Future<void> _activateHiveDatabase() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(WeatherDomainAdapter().typeId)) {
    Hive.registerAdapter<WeatherDomain>(WeatherDomainAdapter());
  }
  if (!Hive.isAdapterRegistered(TemperatureDomainAdapter().typeId)) {
    Hive.registerAdapter<TemperatureDomain>(TemperatureDomainAdapter());
  }
  if (!Hive.isAdapterRegistered(FavoriteCityAdapter().typeId)) {
    Hive.registerAdapter<FavoriteCity>(FavoriteCityAdapter());
  }

  await Hive.openBox<WeatherDomain>(Constants.weatherBoxName);
  await Hive.openBox<FavoriteCity>(Constants.favoriteCityBoxName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RockNClouds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/favorites': (context) => const FavoritesPage(),
      },
    );
  }
}
