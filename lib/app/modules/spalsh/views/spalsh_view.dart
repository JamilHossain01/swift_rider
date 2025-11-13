import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/modules/on_boarding/views/on_boarding_view.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/spalsh_controller.dart';

class SplashView extends GetView<SpalshController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpalshController controller = Get.put(SpalshController());

    // Add a Future.delayed to navigate to OnBoardingView after some time
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => const OnBoardingView());
    });

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0, // You can animate this opacity between 0 and 1
          duration: const Duration(seconds: 2),
          child: AnimatedScale(
            scale: 1.0, // You can animate this scale value from 0.0 to 1.0
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut, // Customize curve for animation effect
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.role, // Replace with your logo asset
                  height: 234.h,width: 216.w,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
