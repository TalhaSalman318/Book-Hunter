import 'package:book_hunt/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReuseableButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  const ReuseableButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 290.w,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
