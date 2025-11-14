import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/modules/setting/views/about_view.dart';
import 'package:swift_ride/app/modules/setting/views/privacy_policy.dart';
import 'package:swift_ride/app/modules/setting/views/termOcondition_view.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../uitilies/app_colors.dart';
import '../../profile/views/edite_profile_view.dart';
import '../../profile/views/settings_view.dart';
import '../controllers/setting_controller.dart';
import '../widgets/setting_item.dart';

// Reusable Setting Item Widget


class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.put(SettingController());
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Settings'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          // Settings Header
          CustomText(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            textAlign: TextAlign.start,
            text: 'Settings',
            color: AppColors.authTextColor,
            useSFPro: true,

          ),
          // SizedBox(height: 16.0),

          // Edit Profile
          SettingItem(
            title: 'Edit Profile',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>EditProfileScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Notification with Switch
          Obx(() => SettingItem(
            title: 'Notification',
            trailing: Switch(
              value: controller.notificationValue.value, // Example state from controller
              onChanged: (value) => controller.toggleNotification(value),
              activeColor: Colors.blue,
            ),
            onTap: () {},
          )),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Account Setting
          SettingItem(
            title: 'Account Setting',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>AccountSettingsScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 8.h,),

          // Legal Header
          CustomText(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            text: 'Legal',
            color: AppColors.authTextColor,
          ),

          // Term & Conditions
          SettingItem(
            title: 'Term & Conditions',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>TermsConditionsView());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Privacy Policy
          SettingItem(
            title: 'Privacy Policy',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>PrivacyPolicyScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // About Us
          SettingItem(
            title: 'About Us',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>AboutUsView());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Delete Account
          SettingItem(
            title: 'Delete Account',
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete, color: AppColors.bgColor, size: 16),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}