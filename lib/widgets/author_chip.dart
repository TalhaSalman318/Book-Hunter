import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/screens/author/author_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/author_provider.dart';

class AuthorChip extends StatefulWidget {
  final String authorId;

  const AuthorChip({super.key, required this.authorId});

  @override
  State<AuthorChip> createState() => _AuthorChipState();
}

class _AuthorChipState extends State<AuthorChip> {
  @override
  void initState() {
    super.initState();

    // ✅ Author preload here
    Future.microtask(() {
      context.read<AuthorProvider>().fetchAuthor(widget.authorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthorProvider>();
    final author = provider.getAuthor(widget.authorId);

    return ActionChip(
      label: Text(
        author?.name ?? "Unknown",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      avatar: Icon(Icons.person, size: 18.sp),
      backgroundColor: AppColors.mainColor.withOpacity(0.1),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthorScreen(authorId: widget.authorId),
          ),
        );
      },
    );
  }
}
