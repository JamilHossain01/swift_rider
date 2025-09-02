import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../common widget/log_in_field.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController =
      TextEditingController(text: 'Istiaq Ahmed');
  final TextEditingController emailController =
      TextEditingController(text: 'deanna.curti@example.com');
  final TextEditingController genderController =
      TextEditingController(text: 'Male');
  final TextEditingController phoneController =
      TextEditingController(text: '+880156780****');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Edit Profile'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        child: Image.asset(
                          'assets/profile_placeholder.png',
                          // Replace with your placeholder asset
                          height: 80,
                          width: 80,
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
                  GestureDetector(
                    onTap: () {
                      // Handle profile picture change
                    },
                    child: CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      textAlign: TextAlign.center,
                      text: 'Change profile picture',
                      color: Colors.blue,
                    ),
                  ),
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
              controller: nameController,
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Email Field
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email...',
              prefixAsset1: AppImages.email,
              // Replace with your email icon asset
              controller: emailController,
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Gender Field
            CustomTextField(
              labelText: 'Gender',
              hintText: 'Select gender...',
              prefixAsset1: AppImages.call,
              // Replace with your gender icon asset
              controller: genderController,
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Phone Field
            CustomTextField(
              labelText: 'Phone',
              hintText: 'Enter your phone...',
              prefixAsset1: AppImages.call,
              // Replace with your phone icon asset
              controller: phoneController,
              onChanged: (value) {},
            ),
            SizedBox(height: 24),

            // Save & Update Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle save and update
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                  text: 'Save & Update',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
