import 'package:book_hunt/providers/favourites_provider.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
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
          ? const Center(
              child: Text(
                "No favorites yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final fav = favoriteProvider.favorites[index];
                final workId = (fav['bookId'] ?? '').replaceAll("/works/", '');

                return GestureDetector(
                  onTap: () {
                    if (workId.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkDetailScreen(workId: workId),
                        ),
                      );
                    }
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        children: [
                          // Cover Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child:
                                (fav['coverId'] != null && fav['coverId'] != 0)
                                ? Image.network(
                                    "https://covers.openlibrary.org/b/id/${fav['coverId']}-M.jpg",
                                    width: 70.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 70.w,
                                    height: 100.h,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.book, size: 40),
                                  ),
                          ),
                          SizedBox(width: 12.w),

                          // Title + extra info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fav['title'] ?? "No title",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Remove Button
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              favoriteProvider.removeFavorite(fav['bookId']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
