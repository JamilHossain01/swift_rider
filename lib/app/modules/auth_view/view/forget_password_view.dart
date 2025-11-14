// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


import '../../../common controller/custom_phone_field.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import 'otp_verify_filed_view.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  String? countryCode;
  String? localNumber;

  final TextEditingController _numberController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Forget Password"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),


              CustomText(
                color: AppColors.authTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.sp,
                  text: "Forgot Password"),
              SizedBox(height: 10.h),

              CustomText(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,


                textAlign: TextAlign.start,
                text:
                    "Don’t worry it accours, please enter the email address linked with your account.",
                color: AppColors.authTextColor,
              ),
              SizedBox(height: 30),


              /// Phone number field
              CustomPhoneTextField(
                labelText: 'Phone Number',
                hintText: '+880 156780****',
                prefixAsset: AppImages.call,
                controller: phoneController,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => OTPVerifyView(phoneNumber: '',));
                  },
                  iconWant: false,
                  btnText: 'Send Code',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
