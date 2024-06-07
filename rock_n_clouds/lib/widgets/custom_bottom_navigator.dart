import 'package:flutter/material.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';

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
            Navigator.of(context).pushReplacementNamed('/nextShows');
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed('/search');
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed('/favorites');
            break;
        }
      },
      indicatorColor: Colors.amber,
      selectedIndex: BottomNavigatorRoutes.values.indexOf(currentRoute),
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.next_week_rounded),
          icon: Icon(Icons.next_week_outlined),
          label: TextData.nextShows,
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.search),
          icon: Icon(Icons.search),
          label: TextData.search,
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.star),
          icon: Icon(Icons.star_border_purple500_rounded),
          label: TextData.favorites,
        ),
      ],
    );
  }
}

enum BottomNavigatorRoutes {
  nextShows,
  search,
  favorites,
}
