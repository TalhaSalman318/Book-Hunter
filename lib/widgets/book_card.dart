import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final BookWorkModel? bookWorkModel;

  const BookCard({super.key, this.bookWorkModel});

  @override
  Widget build(BuildContext context) {
    if (bookWorkModel == null) {
      return const SizedBox.shrink(); // ✅ agar null aaya to empty widget
    }

    final coverProvider = Provider.of<CoverProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        final workId = (bookWorkModel!.key ?? '').replaceAll("/works/", '');
        if (workId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WorkDetailScreen(workId: workId)),
          );
        }
      },
      child: SizedBox(
        width: 140.w, // ✅ fixed width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Image
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Icon(Icons.error),
            ),

            const SizedBox(height: 8),

            // 📖 Title
            Text(
              bookWorkModel!.title ?? 'No title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
