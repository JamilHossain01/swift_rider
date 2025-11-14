// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swift_ride/app/modules/auth_view/widget/otp_form_widget.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../../uitilies/app_string.dart';
import 'create_new_password_view.dart';

class OTPVerifyView extends StatefulWidget {
  final String phoneNumber;

  const OTPVerifyView({super.key, required this.phoneNumber});

  @override
  State<OTPVerifyView> createState() => _OTPVerifyViewState();
}

class _OTPVerifyViewState extends State<OTPVerifyView> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Verify OTP"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              CustomText(
                fontWeight: FontWeight.bold,
                color: AppColors.authTextColor,
                fontSize: 24.sp,
                text: "Verification",
              ),
              SizedBox(height: 20),
              CustomText(
                textAlign: TextAlign.start,
                fontSize: 16.sp,
                text: "Please enter the 6-digit code sent to your phone number.",
                color: AppColors.authTextColor,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEAECF0),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      fontSize: 16.sp,
                      text: widget.phoneNumber.replaceRange(6, widget.phoneNumber.length, '****'),
                      fontWeight: FontWeight.w400,
                      color: AppColors.authTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              OtpForm(
                controller: otpController,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    text: 'If you didn’t receive a code, ',
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add resend OTP logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Resend OTP logic to be implemented')),
                      );
                    },
                    child: CustomText(
                      text: "Resend OTP",
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  onTap: () {
                    if (otpController.text.length == 6) {
                      // Validate OTP (e.g., check with backend)
                      Get.to(() => CreateNewPasswordView());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid 6-digit OTP')),
                      );
                    }
                  },
                  iconWant: false,
                  btnText: 'Submit',
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