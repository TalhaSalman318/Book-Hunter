import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book_hunt/services/favorite_service.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService _service = FavoriteService();
  List<Map<String, dynamic>> _favorites = [];
  StreamSubscription? _subscription;

  List<Map<String, dynamic>> get favorites => _favorites;

  FavoriteProvider() {
    _listenToFavorites(); // ✅ start listening automatically
  }

  void _listenToFavorites() {
    _subscription = _service.getUserFavorites().listen((data) {
      _favorites = data;
      notifyListeners();
    });
  }

  bool isFavorite(String bookId) {
    return _favorites.any((fav) => fav['bookId'] == bookId);
  }

  Future<void> toggleFavorite(String bookId, String title, int coverId) async {
    if (isFavorite(bookId)) {
      await _service.removeFromFavorites(bookId);
    } else {
      await _service.addToFavorites(bookId, title, coverId);
    }
    // No need to manually update _favorites, stream will handle it
  }

  Future<void> removeFavorite(String bookId) async {
    await _service.removeFromFavorites(bookId);
    // Stream updates UI automatically
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
