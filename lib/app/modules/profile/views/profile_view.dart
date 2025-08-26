import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/home_screen_app_bar.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Profile'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.authTextColor.withOpacity(0.20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Profile Section
                Row(
                  children: [
                    Image.asset(
                      AppImages.profile1,
                      height: 50.h,
                      width: 50.w,
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          textAlign: TextAlign.start,
                          text: 'Jenny Wilson',
                          color: AppColors.authTextColor,
                        ),
                        CustomText(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                          text: '+00 (207) 555-0119',
                          color: AppColors.authTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                /// Menu List
                _buildMenuItem(AppImages.payment, 'Payment',(){}),
                _buildDashedDivider(),
                _buildMenuItem(AppImages.customerSupport, 'Customer Support',(){}),
                _buildDashedDivider(),
                _buildMenuItem(AppImages.settings, 'Settings',(){}),
                _buildDashedDivider(),
                _buildMenuItem(AppImages.logOut, 'Log out',(){}),

                /// Add extra gap after last item
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Menu Item
  Widget _buildMenuItem(String iconPath, String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, height: 30.h, width: 30.w),
              SizedBox(width: 10.w),
              CustomText(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                textAlign: TextAlign.start,
                text: title,
                color: AppColors.authTextColor,
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,  // Use the passed callback here
            child: const Icon(Icons.chevron_right, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /// Dashed Divider
  Widget _buildDashedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashWidth = 6.0;
          final dashHeight = 1.5;
          final dashCount = (constraints.maxWidth / (2 * dashWidth)).floor();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
