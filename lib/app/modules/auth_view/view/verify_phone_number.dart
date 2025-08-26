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
import 'login_auth_view.dart';
import 'otp_verify_filed_view.dart';

class VerifyPhoneNumberView extends StatefulWidget {
  VerifyPhoneNumberView({super.key});

  @override
  State<VerifyPhoneNumberView> createState() => _VerifyPhoneNumberViewState();
}

class _VerifyPhoneNumberViewState extends State<VerifyPhoneNumberView> {
  final _formKey = GlobalKey<FormState>();
  String? fullPhoneNumber;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Forget Password"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                CustomText(
                  color: AppColors.authTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.sp,
                  text: "Forgot Password",
                ),
                SizedBox(height: 10.h),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  textAlign: TextAlign.start,
                  text:
                  "Don’t worry it accours, please enter the phone number linked with your account.",
                  color: AppColors.authTextColor,
                ),
                SizedBox(height: 30),
                /// Phone number field
                IntlPhoneField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Select Country and Enter Phone Number',
                    labelText: 'Phone Number',
                  ),
                  initialCountryCode: 'BD', // Default to Bangladesh
                  onChanged: (phone) {
                    setState(() {
                      fullPhoneNumber = phone.completeNumber; // Update full phone number
                    });
                  },
                  showCountryFlag: true,
                  showDropdownIcon: true,
                  dropdownIconPosition: IconPosition.trailing,
                  dropdownTextStyle: TextStyle(fontSize: 16.sp),
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CustomButtonWidget(
                    btnColor: AppColors.mainColor,
                    onTap: () {
                      if (_formKey.currentState!.validate() && fullPhoneNumber != null) {
                        Get.to(() => OTPVerifyView(phoneNumber: fullPhoneNumber!));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a valid phone number')),
                        );
                      }
                    },
                    iconWant: false,
                    btnText: 'Send Code',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}