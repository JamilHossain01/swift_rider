import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class ChatListCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String subtitle;
  final double? rating;

  const ChatListCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.subtitle,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left section: Profile image and text
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.authTextColor.withOpacity(0.1)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    profileImage,
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: name,
                    color: AppColors.authTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: subtitle,
                    color: AppColors.authTextColor.withOpacity(0.50),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ],
          ),
          // Right section: Rating
          if (rating != null)
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  textAlign: TextAlign.start,
                  text: "(${rating!.toStringAsFixed(1)})",
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ],
            ),
        ],
      ),
    );
  }
}