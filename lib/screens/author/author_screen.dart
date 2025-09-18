import 'package:flutter/material.dart';

class AuthorScreen extends StatelessWidget {
  final String authorId;

  const AuthorScreen({super.key, required this.authorId});

  @override
  Widget build(BuildContext context) {
    // Yaha tum provider se author ka detail fetch karaoge
    // Example ke liye dummy UI bana raha hoon
    return Scaffold(
      appBar: AppBar(title: const Text("Author Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 16),
            Text("Author ID: $authorId", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
              "Author Name: (API se fetch karna hai)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Bio: (API se author ki bio ya works fetch karke dikhayenge)",
            ),
          ],
        ),
      ),
    );
  }
}
