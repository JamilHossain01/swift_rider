import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swift_ride/app/modules/auth_view/view/signUpOtp_view.dart';
import 'package:swift_ride/app/modules/auth_view/view/verify_phone_number.dart';

import '../../../common controller/custom_phone_field.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/log_in_field.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controller/password_indicator_controler.dart';
import '../controller/sign_in_controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignInController controller = Get.put(SignInController());

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final PasswordController pwdController = Get.put(PasswordController());


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
                Center(child: CustomText(text: 'Sign up', fontSize: 20.sp, fontWeight: FontWeight.w600)),

                Center(
                  child: Image.asset(
                    AppImages.role, // Replace with your logo asset
                    height: 180,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Full Name',
                  hintText: 'Istiak Ahmed',
                  prefixAsset1: AppImages.user, // Replace with user icon asset
                  controller: fullNameController,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'deanna.curtis@example.com',
                  prefixAsset1: AppImages.email, // Replace with email icon asset
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  labelText: 'Add your Address',
                  hintText: 'Add your Address',
                  prefixAsset1: AppImages.location, // Replace with location icon asset
                  controller: addressController,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Password ...',
                  prefixAsset1: AppImages.password,
                  showObscure: true,
                  controller: passwordController,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(text: 'Strong', color: AppColors.mainColor,),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CustomButtonWidget(
                    btnColor: AppColors.mainColor,
                    onTap: () {
                      // Add navigation or validation logic here
                      Get.to(() => VerifyPhoneNumberView());
                    },
                    iconWant: false,
                    btnText: 'Next',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(color: Colors.grey, width: 100, height: 1.5),
                    CustomText(text: "Or continue with"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Already have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      // onTap: () => Get.to(() => VerifyPhoneNumberView()),
                      child: CustomText(
                        text: "Log in",
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
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