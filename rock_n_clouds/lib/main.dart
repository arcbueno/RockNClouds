import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_clouds/pages/home/home_page.dart';
import 'package:rock_n_clouds/service_locator.dart';
import 'package:rock_n_clouds/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hive = await BoxCollection.open(
    'RockNClouds',
    {
      Constants.weatherBoxName,
    },
    path: './',
  );
  ServiceLocator.setup(hive);
  runApp(const MyApp());
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
      home: const HomePage(),
    );
  }
}
