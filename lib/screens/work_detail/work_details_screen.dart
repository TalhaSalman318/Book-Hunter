import 'package:book_hunt/core/env.dart';
import 'package:book_hunt/screens/editions/edition_screen.dart';
import 'package:book_hunt/widgets/color.dart';
import 'package:book_hunt/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';
import 'package:book_hunt/providers/author_provider.dart';
import 'package:book_hunt/widgets/author_chip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkDetailScreen extends StatefulWidget {
  final String workId;
  const WorkDetailScreen({super.key, required this.workId});

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WorkDetailProvider>().fetchWorkDetail(widget.workId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workDetailProvider = context.watch<WorkDetailProvider>();

    if (workDetailProvider.isLoading) {
      return const Scaffold(body: Center(child: WorkDetailShimmer()));
    }

    if (workDetailProvider.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(workDetailProvider.errorMessage!)),
      );
    }

    final work = workDetailProvider.workDetail;
    if (work == null) {
      return const Scaffold(body: Center(child: Text("No details found")));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          FavoriteButton(
            bookId:
                widget.workId ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            title: work['title'] ?? "No title", // 🔹 title string
            coverId: (work['covers'] != null && work['covers'].isNotEmpty)
                ? work['covers'][0]
                : 0, // 🔹 agar cover hai to use karo, warna 0
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 200.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                      image:
                          (work['covers'] != null && work['covers'].isNotEmpty)
                          ? DecorationImage(
                              image: NetworkImage(
                                "https://covers.openlibrary.org/b/id/${work['covers'][0]}-L.jpg",
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: (work['covers'] == null || work['covers'].isEmpty)
                        ? const Icon(Icons.book, size: 60, color: Colors.grey)
                        : null,
                  ),

                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // Title
                        Text(
                          maxLines: 4,
                          work['title'] ?? "No title",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        Wrap(
                          spacing: 8,
                          children: (work['authors'] as List? ?? []).map((a) {
                            final rawKey = a['author']?['key'] ?? "";
                            final authorId = rawKey.replaceAll("/authors/", "");

                            return AuthorChip(authorId: authorId);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Book",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Description
              Text(
                work['description'] is Map
                    ? (work['description']['value'] ?? "No description")
                    : (work['description'] ?? "No description"),
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  final workId = work['key'].replaceAll("/works/", "");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditionsScreen(workId: workId),
                    ),
                  );
                },
                child: Container(
                  height: 40.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Editions",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             Text(
//               work['title'] ?? "No title",
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 12),

//             // Description
//             Text(
//               work['description'] is Map
//                   ? (work['description']['value'] ?? "No description")
//                   : (work['description'] ?? "No description"),
//             ),

//             const SizedBox(height: 16),

//             // Author chips
//             Wrap(
//               spacing: 8,
//               children: (work['authors'] as List? ?? []).map((a) {
//                 final rawKey = a['author']?['key'] ?? "";
//                 final authorId = rawKey.replaceAll("/authors/", "");

//                 return AuthorChip(authorId: authorId);
//               }).toList(),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         EditionsScreen(workId: widget.workId), // work ka key
//                   ),
//                 );
//               },
//               child: const Text("View Editions"),
//             ),
//           ],
//         ),