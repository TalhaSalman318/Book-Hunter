import 'package:book_hunt/services/open_library_api.dart';

class CoverRepository {
  final OpenLibraryApi api;
  CoverRepository(this.api);

  /// Get cover image URL for a book/edition
  String getCoverUrl(int coverId, {String size = "M"}) {
    return api.coverUrlFromCoverId(coverId, size: size);
  }
}
