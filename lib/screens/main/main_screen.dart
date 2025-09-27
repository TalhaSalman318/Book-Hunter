import 'package:book_hunt/core/theme.dart';
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
            onTap: nav.setIndex,
            selectedItemColor:
                AppColors.whiteColor, // 🔹 selected icon/text color
            backgroundColor: AppColors.mainColor, // 🔹 background color

            showUnselectedLabels: true, // 🔹 unselected label bhi show karo
            // expects (int) => void
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/home.png",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/search.png",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/heart.png",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/profile.png",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
