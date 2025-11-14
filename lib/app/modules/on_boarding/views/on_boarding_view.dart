import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/custom_button_widget.dart';
import 'package:swift_ride/app/routes/app_pages.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.onboardOne,
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent blue overlay

          // Bottom curved container with content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: Stack(
                children: [
                  // Top gradient overlay inside the container
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                      ),
                    ),
                  ),

                  // Actual content
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 1.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        CustomText(
                          text: 'Go Anywhere, Anytime.',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        CustomText(
                          text: 'Easy and Fast',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text:
                              'From daily commutes to special trips, we’re here to take you wherever you need to go with ease.',
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10.h),
                        CustomButtonWidget(
                          btnText: 'Get Started Now',
                          onTap: () {
                            Get.toNamed(Routes.ROLE_SELECTION);
                          },
                          iconWant: false,
                          btnColor: AppColors.buttonColor,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
