import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart'; // Import your AppImages class

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final String iconPath;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.iconPath, // Path to the icon from assets
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF2F4F7),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r), // Rounded corners for the card
      ),
      elevation: 3, // Add some elevation for the card
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [
            // Icon from assets
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Circle shape for the icon
              ),
              child: Image.asset(
                iconPath, // Custom icon from assets
                height: 24.h,
                width: 24.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 8.w), // Space between the icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomText(
                    text: title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8.h), // Space between title and subtitle
                  // Subtitle
                  CustomText(
                    text: subtitle,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF3E4958),
                  ),
                  SizedBox(height: 8.h), // Space between subtitle and timestamp
                  // Timestamp
                  Row(
                    children: [
                      Image.asset(
                        AppImages.sClock, // Custom icon from assets
                        height: 14.h,
                        width: 14.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 8.w), // Space between subtitle and timestamp

                      CustomText(
                        text: timeAgo,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow icon for next action
            Icon(
              Icons.arrow_forward_ios,
              size: 16.h,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
