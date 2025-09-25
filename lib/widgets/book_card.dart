import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCard extends StatelessWidget {
  final BookWorkModel? bookWorkModel;

  const BookCard({super.key, this.bookWorkModel});

  @override
  Widget build(BuildContext context) {
    if (bookWorkModel == null) {
      return const SizedBox.shrink(); // ✅ null handle
    }

    final workId = (bookWorkModel!.key ?? '').replaceAll("/works/", '');
    final title = bookWorkModel!.title ?? "No title";

    // ✅ Cover Id pick from list
    final coverId =
        (bookWorkModel!.covers != null && bookWorkModel!.covers!.isNotEmpty)
        ? bookWorkModel!.covers!.first
        : 0;

    // ✅ OpenLibrary cover URL
    final coverUrl = coverId != 0
        ? "https://covers.openlibrary.org/b/id/${coverId.toString()}-M.jpg"
        : null;

    return GestureDetector(
      onTap: () {
        if (workId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WorkDetailScreen(workId: workId)),
          );
        }
      },
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Cover Image
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: coverUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint("Cover not found: $coverUrl");
                          return const Icon(Icons.book, size: 60);
                        },
                      ),
                    )
                  : const Icon(Icons.book, size: 60),
            ),

            const SizedBox(height: 8),

            // 📖 Title
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
