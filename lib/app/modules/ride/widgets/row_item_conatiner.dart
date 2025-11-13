import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

class ResultItem extends StatelessWidget {
  final String imagePath;
  final Color color;
  final VoidCallback? onTap; // Added optional onTap callback

  const ResultItem({
    required this.imagePath,
    required this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when tapped
      child: Container(
        height: 56.h,
        width: 56.w,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain), // Added size and fit for better display
      ),
    );
  }
}