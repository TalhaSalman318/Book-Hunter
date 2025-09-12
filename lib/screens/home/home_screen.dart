import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:book_hunt/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/search_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchBooksProvider>(context);
    final searchController = TextEditingController();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Hunt')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.searchGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search books...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    provider.search(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                        color: AppColors.fontGreyColor,
                        fontSize: width * 0.035,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: width * 0.04,
                      color: AppColors.fontGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
