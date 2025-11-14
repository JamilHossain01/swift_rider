// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../../common widget/custom_button_widget.dart';
import '../../../../../common widget/home_screen_app_bar.dart';
import '../../../../../common widget/log_in_field.dart';
import '../../../../../uitilies/app_colors.dart';
import '../../../../../uitilies/app_images.dart';
import '../../../../auth_view/controller/password_indicator_controler.dart';
import '../../../../auth_view/view/login_auth_view.dart';



class DriverChangedNewPasswordView extends StatelessWidget {
  const DriverChangedNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordController pwdController = Get.put(PasswordController());

    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Change Password'),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: SingleChildScrollView( // Added SingleChildScrollView here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      CustomText(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.sp,
                          text: "Change New Password!"),
                      SizedBox(height: 10),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: "Enter a different password with the previous!",
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Current Password',
                        hintText: 'Current Password',
                        prefixAsset1: AppImages.password,
                        showObscure: true,
                        onChanged: pwdController.checkPasswordStrength,
                      ),   CustomTextField(
                        labelText: 'New Password ...',
                        hintText: 'New Password ...',
                        prefixAsset1: AppImages.password,
                        showObscure: true,
                        onChanged: pwdController.checkPasswordStrength,
                      ),
                      CustomTextField(
                        labelText: 'Confirm Password ...',
                        hintText: 'Confirm Password ...',
                        prefixAsset1: AppImages.password,
                        showObscure: true,
                        onChanged: pwdController.checkPasswordStrength,
                      ),
                      SizedBox(height: 8),
                      Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                      color: pwdController.strength.value > index
                                          ? AppColors.mainColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _strengthText(pwdController.strength.value),
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          btnColor: AppColors.mainColor,
                          onTap: () {
                            Get.to(() => SignInView());
                          },
                          iconWant: false,
                          btnText: 'Save',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _strengthText(int strength) {
    switch (strength) {
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Medium';
      case 4:
        return 'Strong';
      case 5:
        return 'Very Strong';
      default:
        return '';
    }
  }
}