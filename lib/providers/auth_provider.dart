import 'package:book_hunt/repositories/author_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repo;
  User? _user;

  AuthProvider(this._repo) {
    _repo.authStateChanges.listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isSignedIn => _user != null;

  Future<void> signInWithGoogle() async {
    try {
      _user = await _repo.signInWithGoogle();
      notifyListeners();
    } catch (e) {
      debugPrint("Google Sign-In error: $e");
      rethrow;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      _user = await _repo.signInWithEmail(email, password);
      notifyListeners();
    } catch (e) {
      debugPrint("Email Sign-In error: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    _user = null;
    notifyListeners();
  }
}
