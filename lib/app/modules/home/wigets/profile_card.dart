import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';
import '../../../common widget/custom text/custom_text_widget.dart';

class ProfileCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String subtitle;
  final int notificationCount;  // Integer to hold the notification count
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.subtitle,
    required this.notificationCount,  this.onTap,  // Notification count passed as an integer
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Left section: Profile image and text
          Row(
            children: [
              // Profile image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ensure the image is circular
                  border: Border.all(color: AppColors.authTextColor.withOpacity(0.1)),
                ),
                child: ClipOval(
                  child: Image.asset(
                    profileImage,
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w), // Space between profile image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  CustomText(
                    textAlign: TextAlign.start,
                    text:subtitle ,
                    color: Color(0xFF7B7B7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  SizedBox(height: 5.h),
                  // Subtitle
                  CustomText(
                    textAlign: TextAlign.start,
                    text:name ,
                    color: AppColors.homeTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ],
          ),
          Spacer(), // Spacer to push the notification icon to the far right
          // Right section: Notification Bell Icon
          if (notificationCount > 0)
            Stack(
              clipBehavior: Clip.none, // Allow the notification badge to overflow
              children: [
                GestureDetector(
                  onTap: onTap,

                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.authTextColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10-.0),
                      child: Image.asset(
                        AppImages.bell,
                        height: 24.h, // Adjust the size of the bell icon
                        width: 24.w,
                      ),
                    ),
                  ),
                ),
                // Notification Badge
                Positioned(
                  top: -4.h,
                  right: -4.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red, // Red background for the badge
                      shape: BoxShape.circle, // Circular badge
                    ),
                    child: CustomText(
                      text: notificationCount.toString(),
                      color: Colors.white, // White color for the count
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp, // Adjust font size
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
