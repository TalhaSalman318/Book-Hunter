import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String coverUrl;
  const BookCard({super.key, required this.title, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(coverUrl, fit: BoxFit.cover),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
