import 'package:book_hunt/providers/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final String bookId;
  final String title;
  final int coverId;

  const FavoriteButton({
    super.key,
    required this.bookId,
    required this.title,
    required this.coverId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favProvider, _) {
        final isFav = favProvider.isFavorite(bookId);

        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
          onPressed: () async {
            try {
              await favProvider.toggleFavorite(bookId, title, coverId);
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Error: $e")));
            }
          },
        );
      },
    );
  }
}
