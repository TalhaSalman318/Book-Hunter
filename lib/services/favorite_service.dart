import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  /// ✅ Add to favorites
  Future<void> addToFavorites(String bookId, String title, int coverId) async {
    if (_uid == null) throw Exception("User not logged in");

    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("favorites")
        .doc(bookId)
        .set({
          "bookId": bookId, // ✅ ye line add karo
          "title": title,
          "coverId": coverId,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }

  /// ✅ Remove from favorites
  Future<void> removeFromFavorites(String bookId) async {
    if (_uid == null) throw Exception("User not logged in");

    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("favorites")
        .doc(bookId)
        .delete();
  }

  /// ✅ Check if a book is favorite
  Future<bool> isFavorite(String bookId) async {
    if (_uid == null) return false;

    final doc = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("favorites")
        .doc(bookId)
        .get();

    return doc.exists;
  }

  /// ✅ Stream all favorites of current user
  Stream<List<Map<String, dynamic>>> getUserFavorites() {
    if (_uid == null) return const Stream.empty();

    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("favorites")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
