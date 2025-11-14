import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath; // Now accepts iconPath instead of IconData

  const LocationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath, // Accepting the path of the asset icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Icon section from assets
          Image.asset(
            iconPath, // Load the image asset
            height: 50.h,
            width: 50.w,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.homeTextColor,
              ),

              SizedBox(height: 4.h),
              CustomText(
                text: subtitle,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.homeTextColor.withOpacity(0.60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
