import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book_hunt/services/favorite_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService _service = FavoriteService();
  List<Map<String, dynamic>> _favorites = [];
  StreamSubscription? _subscription;
  StreamSubscription<User?>? _authSubscription;

  List<Map<String, dynamic>> get favorites => _favorites;

  FavoriteProvider() {
    _listenToAuth(); // ✅ auth listener add
  }

  void _listenToAuth() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _subscription?.cancel(); // purani stream band karo
      _favorites = [];
      notifyListeners();

      if (user != null) {
        // ✅ dobara login → nayi stream lagao
        _subscription = _service.getUserFavorites().listen((data) {
          _favorites = data;
          notifyListeners();
        });
      }
    });
  }

  bool isFavorite(String bookId) {
    return _favorites.any((fav) => fav['bookId'] == bookId);
  }

  Future<void> toggleFavorite(String bookId, String title, int coverId) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User not logged in");
    }

    if (isFavorite(bookId)) {
      await _service.removeFromFavorites(bookId);
    } else {
      await _service.addToFavorites(bookId, title, coverId);
    }
  }

  Future<void> removeFavorite(String bookId) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User not logged in");
    }
    await _service.removeFromFavorites(bookId);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
