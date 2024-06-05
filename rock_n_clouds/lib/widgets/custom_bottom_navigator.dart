import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatelessWidget {
  final BottomNavigatorRoutes currentRoute;

  const CustomBottomNavigator({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        if (index == BottomNavigatorRoutes.values.indexOf(currentRoute)) return;
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/');
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed('/favorites');
            break;
        }
      },
      indicatorColor: Colors.amber,
      selectedIndex: BottomNavigatorRoutes.values.indexOf(currentRoute),
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.star),
          icon: Icon(Icons.star_border_purple500_rounded),
          label: 'Home',
        ),
      ],
    );
  }
}

enum BottomNavigatorRoutes {
  home,
  favorites,
}
