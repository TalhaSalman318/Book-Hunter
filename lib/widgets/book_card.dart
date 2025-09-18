import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String coverUrl;
  final BookWorkModel bookWorkModel;

  const BookCard({
    super.key,
    required this.title,
    required this.bookWorkModel,
    required this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkDetailScreen(
              workId: (bookWorkModel.key ?? '').replaceAll("/works/", ''),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 140.w, // ✅ fixed width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 📌 Image with fixed height
            Container(
              height: 180.h, // ✅ fixed height for covers
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Image.network(
                coverUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180.h,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            // 📌 Title text
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
