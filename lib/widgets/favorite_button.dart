import 'package:book_hunt/providers/favourites_provider.dart';
import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/screens/auth/log_in_screen.dart';
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
    return Consumer2<AuthProvider, FavoriteProvider>(
      builder: (context, authProvider, favProvider, _) {
        final isFav = favProvider.isFavorite(bookId);

        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
          onPressed: () async {
            try {
              if (authProvider.user == null) {
                // ✅ Agar user login nahi hai
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Login Required"),
                    content: const Text("Please login to like this book."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx); // dialog band karo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                );
              } else {
                // ✅ Agar user login hai
                await favProvider.toggleFavorite(bookId, title, coverId);
              }
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
