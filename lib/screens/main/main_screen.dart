import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/bottom_nav_provider.dart';
import 'package:book_hunt/screens/home/home_screen.dart';
import 'package:book_hunt/screens/search/search_screen.dart';
import 'package:book_hunt/screens/favorites/favorites_screen.dart';
import 'package:book_hunt/screens/settings/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // NOTE: make these const if your screen constructors allow it
  static final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          // IndexedStack preserves each tab's state instead of rebuilding them.
          body: IndexedStack(index: nav.currentIndex, children: _screens),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: nav.currentIndex,
            onTap: nav.setIndex, // expects (int) => void
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),

                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
