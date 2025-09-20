import 'package:flutter/foundation.dart';
import 'package:book_hunt/repositories/cover_repository.dart';

class CoverProvider with ChangeNotifier {
  final CoverRepository repository;
  CoverProvider(this.repository);

  String getCoverUrl(int coverId, {String size = "M"}) {
    return repository.getCoverUrl(coverId, size: size);
  }
}
