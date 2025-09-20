import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class WorkDetailShimmer extends StatelessWidget {
  const WorkDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Work Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(height: 200.h, width: 90.w, color: Colors.grey),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, width: 200, color: Colors.grey),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(
                            3,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              height: 20,
                              width: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(height: 40, width: 120, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(height: 16, width: 100, color: Colors.grey),
              const SizedBox(height: 12),
              Container(height: 14, width: double.infinity, color: Colors.grey),
              const SizedBox(height: 8),
              Container(height: 14, width: double.infinity, color: Colors.grey),
              const SizedBox(height: 8),
              Container(height: 14, width: 200, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
