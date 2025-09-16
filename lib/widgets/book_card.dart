import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCard extends StatelessWidget {
  final String title;
  final BookWorkModel bookWorkModel;

  // final String coverUrl;
  const BookCard({super.key, required this.title, required this.bookWorkModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            // child: Image.network(cover.getCoverUrl(), fit: BoxFit.cover),
          ),
          Text(
            title,
            maxLines: 2, // maximum 2 lines tak allow karo
            overflow:
                TextOverflow.ellipsis, // agar 2 lines se lamba ho to "..."
            softWrap: true, // line break allow karega
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
