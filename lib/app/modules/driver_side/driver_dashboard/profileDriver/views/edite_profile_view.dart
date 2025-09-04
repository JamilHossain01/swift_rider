import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/common%20widget/custom_button_widget.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

import '../../../../../common controller/custom_phone_field.dart';
import '../../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../../common widget/home_screen_app_bar.dart';
import '../../../../../common widget/log_in_field.dart';
import '../../../../../uitilies/app_images.dart';

class DriverEditProfileScreen extends StatelessWidget {
  // final TextEditingController nameController =
  //     TextEditingController(text: 'Istiaq Ahmed');
  // final TextEditingController emailController =
  //     TextEditingController(text: 'deanna.curti@example.com');
  // final TextEditingController genderController =
  //     TextEditingController(text: 'Male');
  // final TextEditingController phoneController =
  //     TextEditingController(text: '+880156780****');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Profile Edit'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            AppImages.profile1,
                            // Replace with your placeholder asset
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Handle profile picture change
                    //   },
                    //   child: CustomText(
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 15.sp,
                    //     textAlign: TextAlign.center,
                    //     text: 'Change profile picture',
                    //     color: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Name Field
              CustomTextField(
                labelText: 'Name',
                hintText: 'Enter your name...',
                prefixAsset1: AppImages.user,
                // Replace with your user icon asset
                // controller: nameController,
                onChanged: (value) {},
              ),
              CustomTextField(
                labelText: 'Scan code',
                hintText: 'Enter your name...',
                prefixAsset1: AppImages.scan,
                // Replace with your user icon asset
                // controller: nameController,
                onChanged: (value) {},
              ),
              CustomPhoneTextField(
                labelText: 'Phone Number',
                hintText: '+880 156780****',
                prefixAsset: AppImages.call,
              ),
              // Email Field
              CustomTextField(
                labelText: 'Email',
                hintText: 'Enter your email...',
                prefixAsset1: AppImages.email,
                // Replace with your email icon asset
                // controller: emailController,
                onChanged: (value) {},
              ),
              CustomTextField(
                labelText: 'Location',
                hintText: 'New york 1029,USA',
                prefixAsset1: AppImages.location,
                // Replace with your email icon asset
                // controller: emailController,
                onChanged: (value) {},
              ),

              // Gender Field
              CustomTextField(
                labelText: 'Card number',
                hintText: '123456789',
                prefixAsset1: AppImages.idCard,
                // Replace with your gender icon asset
                // controller: genderController,
                onChanged: (value) {},
              ),

              // Phone Field
              CustomTextField(
                labelText: 'English',
                hintText: 'English',
                prefixAsset1: AppImages.earth,
                // Replace with your phone icon asset
                onChanged: (value) {},
              ),
              SizedBox(height: 24),

              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.asset(AppImages.bmw),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Corolla Hatchback',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                textAlign: TextAlign.start,
                                color: const Color(0xFF1D2939),
                              ),
                              CustomText(
                                text: 'Corolla Allion 25',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                textAlign: TextAlign.start,
                                color: const Color(0xFF475467),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Jenny Wilson (Owner)',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                textAlign: TextAlign.start,
                                color: const Color(0xFF1D2939),
                              ),
                              CustomText(
                                text: 'ID-abc_123_23',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                textAlign: TextAlign.start,
                                color: const Color(0xFF475467),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),

              // Save & Update Button
              CustomButtonWidget(
                btnText: 'Update',
                onTap: () {},
                iconWant: false,
                btnColor:Color(0xFF3A86FF),
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
