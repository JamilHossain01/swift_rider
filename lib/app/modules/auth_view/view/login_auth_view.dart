// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:swift_ride/app/common%20widget/text_diled2.dart';

import 'package:swift_ride/app/modules/auth_view/view/sign_up_view.dart';
import 'package:swift_ride/app/modules/dashboard/views/dashboard_view.dart';

import '../../../common controller/custom_phone_field.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/log_in_field.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../controller/sign_in_controller.dart';
import 'forget_password_view.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  // Instantiate controller
  final SignInController controller = Get.put(SignInController());

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    AppImages.role,
                    height: 180,
                  ),
                ),
                SizedBox(height: 30),

                CustomPhoneTextField(
                  labelText: 'Phone Number',
                  hintText: '+880 156780****',
                  prefixAsset: AppImages.call,
                  controller: phoneController,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Password ...',
                  prefixAsset1: AppImages.password,
                  showObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                ),
                SizedBox(height: 10),

                // Remember Me + Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (_) => controller.toggleRememberMe(),
                          side: BorderSide(color: AppColors.mainColor),
                          activeColor: AppColors.mainColor,
                        )),
                        SizedBox(width: 4),
                        CustomText(
                          text: "Remember Me",
                          fontSize: 16,
                          color: AppColors.mainColor.withOpacity(0.8),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => ForgetPasswordView()),
                      child: CustomText(
                        text: "Forgot Password",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Log in button
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CustomButtonWidget(
                    btnColor: AppColors.mainColor,
                    onTap: () {
                      // Example: Check if Remember Me is enabled
                      print('Remember Me: ${controller.rememberMe.value}');
                      Get.to(() => UserDashboardView());
                    },
                    iconWant: false,
                    btnText: 'Log in',
                  ),
                ),

                SizedBox(height: 20),

                // Or Continue With + Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(color: Colors.grey, width: 100, height: 1.5),
                    CustomText(text: "Or Continue With"),
                    Container(color: Colors.grey, width: 100, height: 1.5),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton(AppImages.google),
                    SizedBox(width: 20),
                    socialButton(AppImages.apple),
                  ],
                ),
                SizedBox(height: 20),

                // Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Don’t have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.to(() => SignUpView()),
                      child: CustomText(
                        text: "Sign Up",
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(String asset) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Image.asset(asset, width: 30),
    );
  }
}
