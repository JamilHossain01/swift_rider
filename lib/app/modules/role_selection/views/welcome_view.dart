
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom_button_widget.dart';
import '../../../routes/app_pages.dart';
import '../../auth_view/view/login_auth_view.dart';
import '../controllers/role_selection_controller.dart';

class WelcomeVIew extends GetView<RoleSelectionController> {
  const WelcomeVIew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(AppImages.role),
            ),
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
            SizedBox(height: 180.h),

            CustomButtonWidget(
              btnText: 'Log in',
              onTap: () {
                Get.to(() => SignInView());
              },
              iconWant: false,
              btnColor: AppColors.buttonColor,
            ),

            SizedBox(height: 10.h,),
            CustomButtonWidget(btnTextColor:Colors.black,
              btnText: 'Sign up', onTap: (){
              Get.toNamed(Routes.ROLE_SELECTION);
            }, iconWant: false,btnColor: AppColors.buttonColor2,),

          ],
        ),
      ),
    );
  }

}

// Example RoleSelectionController (add this in controllers/role_selection_controller.dart)
