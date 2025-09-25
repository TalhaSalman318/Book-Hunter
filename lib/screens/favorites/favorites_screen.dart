import 'package:book_hunt/providers/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favoriteProvider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final fav = favoriteProvider.favorites[index];

                return ListTile(
                  leading: (fav['coverId'] != null && fav['coverId'] != 0)
                      ? Image.network(
                          "https://covers.openlibrary.org/b/id/${fav['coverId']}-M.jpg",
                          width: 50.w,
                          height: 200.h,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.book, size: 40),
                  title: Text(fav['title'] ?? "No title"),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favoriteProvider.removeFavorite(fav['bookId']);
                    },
                  ),
                );
              },
            ),
    );
  }
}
