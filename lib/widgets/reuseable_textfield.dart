import 'package:book_hunt/core/theme.dart';
import 'package:flutter/material.dart';

class ReuseableTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;

  const ReuseableTextfield({
    super.key,
    required this.controller,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            // fillColor: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
