import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/custom_button_widget.dart';
import 'package:swift_ride/app/common%20widget/custom_dropdown_controller.dart';
import 'package:swift_ride/app/common%20widget/home_screen_app_bar.dart';
import 'package:swift_ride/app/modules/home/wigets/location_card.dart';
import 'package:swift_ride/app/modules/home/wigets/profile_card.dart';
import 'package:swift_ride/app/routes/app_pages.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../controllers/home_controller.dart';
import 'notification_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  // Sample list of locations for demonstration purposes
  final List<Map<String, String>> locations = [
    {
      'title': 'Islamic Boarding School Al-Islam',
      'subtitle': 'D.I Panjaitan Street, Purwokerto City',
      'icon': 'school_icon.png',
    },
    {
      'title': 'Pimpom Book Store',
      'subtitle': 'WR. Supratman Street, Purwokerto City',
      'icon': 'store_icon.png',
    },
    {
      'title': 'Delhi Kusuma Hospital’s',
      'subtitle': 'Dr. Soepomo Street, Purwokerto City',
      'icon': 'hospital_icon.png',
    },
  ];
  final List<String> images = [
    AppImages.tripIconContainer,
    AppImages.tripIconContainer1,
    AppImages.tripIconContainer2,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            ProfileCard(
              onTap: () {
                Get.to(() => NotificationView());
              },
              profileImage: AppImages.profile1,
              name: 'Jamil Khan',
              subtitle: 'Good Morning',
              notificationCount: 12,
            ),
            SizedBox(height: 20.h),
            CustomButtonWidget(
              btnText: 'Make a Reservation',
              onTap: () {
                Get.toNamed(Routes.MAKE_RESERVATION);
              },
              iconWant: false,
              btnColor: AppColors.mainColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            SizedBox(height: 10.h),
            // Corrected CustomDropdown implementation

            SizedBox(height: 10.h),
            CustomText(
              textAlign: TextAlign.start,
              text: 'Your Last Trip',
              color: AppColors.homeTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
            // List of locations inside an Expanded widget
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return LocationCard(
                    title: location['title']!,
                    subtitle: location['subtitle']!,
                    iconPath: images[index % images.length], // Cycle through images
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}