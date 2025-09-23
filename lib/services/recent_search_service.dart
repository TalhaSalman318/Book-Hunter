import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchService {
  static const _key = "recent_searches";

  // Save a new search query
  Future<void> addSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(_key) ?? [];

    // remove if already exists (avoid duplicates)
    searches.remove(query);

    // add to start
    searches.insert(0, query);

    // keep only last 10
    if (searches.length > 10) {
      searches = searches.sublist(0, 10);
    }

    await prefs.setStringList(_key, searches);
  }

  // Get all searches
  Future<List<String>> getSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // Clear searches
  Future<void> clearSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
