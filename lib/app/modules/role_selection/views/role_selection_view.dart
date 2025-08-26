import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:swift_ride/app/common%20widget/custom_divider.dart';
import 'package:swift_ride/app/modules/role_selection/views/welcome_view.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.role),
            SizedBox(width: 100,
              child: CustomDivider(

                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10.h),

            CustomText(
              text: 'Drive with SwiftRider',
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              color: Colors.black,
            ),

            SizedBox(height: 5.h),
            CustomText(
              text: 'Earn extra money by driving.',
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              color: Colors.black,
            ),
            SizedBox(height: 20.h),


            _buildOptionContainer('user', 'As a User'),
            SizedBox(height: 15.h),
            _buildOptionContainer('driver', 'As a Driver'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionContainer(String value, String label) {
    return Obx(() {
      final controller = Get.find<RoleSelectionController>();
      final isSelected = controller.selectedRole.value == value;

      return GestureDetector(
        onTap: () {
          if (!isSelected) {
            controller.setSelectedRole(value);
            Future.delayed(const Duration(seconds: 1), () {
              Get.to(() => WelcomeVIew());
            });
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: label,
                fontSize: 16.sp,
                color: isSelected ? Colors.blue : Colors.black,
              ),
              Radio<String>(
                value: value,
                groupValue: controller.selectedRole.value,
                onChanged: (_) {}, // Disabled to avoid double navigation
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
      );
    });
  }
}
