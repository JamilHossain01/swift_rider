import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/modules/home/views/home_view.dart';
import 'package:swift_ride/app/modules/message/views/message_view.dart';
import 'package:swift_ride/app/modules/profile/views/profile_view.dart';
import 'package:swift_ride/app/modules/ride/views/ride_view.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    final screens = [
      HomeView(),
      MessageView(),
      RideView(),

      ProfileView(),

    ];

    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.homeUnActive, // active icon here

              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              AppImages.homeActive, // inactive icon here

              width: 24,
              height: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.message,

              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              AppImages.messageUnActive,

              width: 24,
              height: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.clockUnActive,
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              AppImages.clockActive,
              width: 24,
              height: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.profile,

              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              AppImages.profileUnActive,

              width: 24,
              height: 24,
            ),
            label: '',
          ),
        ],
      )),
    );
  }
}
