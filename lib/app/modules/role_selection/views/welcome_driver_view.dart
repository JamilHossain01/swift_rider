
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom_button_widget.dart';
import '../../../routes/app_pages.dart';
import '../../auth_view/view/driver_sign_in_view.dart';
import '../../auth_view/view/login_auth_view.dart';
import '../controllers/role_selection_controller.dart';

class WelcomeDriverVIew extends GetView<RoleSelectionController> {
  const WelcomeDriverVIew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),

            SizedBox(
              child: Image.asset(AppImages.role,height: 216.h,width: 207.w,),
            ),

            SizedBox( width: 100.w,
                child: Divider()),
            SizedBox(height: 50.h),

            CustomButtonWidget(
              btnText: 'Log in',
              onTap: () {
                Get.to(() => DriverSignInView());
              },
              iconWant: false,
              btnColor: AppColors.buttonColor,
            ),


          ],
        ),
      ),
    );
  }

}

// Example RoleSelectionController (add this in controllers/role_selection_controller.dart)
