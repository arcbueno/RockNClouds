import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rock_n_clouds/widgets/custom_bottom_navigator.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [Placeholder()],
      ),
      bottomNavigationBar: CustomBottomNavigator(
        currentRoute: BottomNavigatorRoutes.favorites,
      ),
    );
  }
}
