import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

class TripButtonWidget extends StatelessWidget {
  final String buttonText;
  final RxString selectedButton;
  final String assetPath;

  TripButtonWidget({
    required this.buttonText,
    required this.selectedButton,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedButton.value = buttonText; // Update selected button
      },
      child: Obx(() {
        final isSelected = selectedButton.value == buttonText;
        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric( vertical: 4.0),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.blueToggle
                : AppColors.grayToggle,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: isSelected
                  ? AppColors.blueToggle
                  : AppColors.grayToggle,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display icon only if needed. Adjust image size as necessary.
              Image.asset(
                assetPath, // Make sure the image path is correct
                width: 14.w,
                height: 14.h,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 4.0), // Space between image and text
              CustomText(
                text: buttonText,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: isSelected
                    ? Colors.white
                    : Colors.black,
              ),
            ],
          ),
        );
      }),
    );
  }
}