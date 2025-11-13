import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart'; // Added for AppImages

class DriverCustomerSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          AppImages.customSupportP,
          height: 24.h,
          width: 24.w,
          fit: BoxFit.contain,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              textAlign: TextAlign.start,
              text: 'Customer Support',
              color: AppColors.authTextColor,
            ),
            CustomText(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              textAlign: TextAlign.start,
              text: 'Online',
              color: Colors.green,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              AppImages.customSupportP,
              height: 24.h,
              width: 24.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // Support Message 1
                _buildSupportMessage(
                  'Have a great working week!!',
                  'Hope you like it',
                  '01:10 PM',
                ),
                // User Message 1 (Audio)
                _buildUserAudioMessage('01:11 PM', '00:16'),
                // Support Message 2
                _buildSupportMessage(
                  'Have a great working week!!',
                  'Hope you like it',
                  '01:12 PM',
                ),
                // User Message 2 (Audio)
                _buildUserAudioMessage('01:14 PM', '00:16'),
                // Support Message 3
                _buildSupportMessage(
                  'Have a great working week!!',
                  'Hope you like it',
                  '01:15 PM',
                ),
                // User Message 3 (Audio)
                _buildUserAudioMessage('01:14 PM', '00:16'),
              ],
            ),
          ),
          // Input Field
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildSupportMessage(String mainText, String subText, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.customSupportP,
            height: 24.h,
            width: 24.w,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFD700), // Yellow bubble
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    textAlign: TextAlign.start,
                    text: mainText,
                    color: AppColors.authTextColor,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    textAlign: TextAlign.start,
                    text: subText,
                    color: AppColors.authTextColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CustomText(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            textAlign: TextAlign.end,
            text: time,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildUserAudioMessage(String time, String duration) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            textAlign: TextAlign.end,
            text: time,
            color: Colors.grey,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue, // Blue bubble
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.audio,
                    height: 20.h,
                    width: 20.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4.w),
                  // Simple waveform simulation with lines
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) => Container(
                      width: 2.w,
                      height: (index % 2 == 0 ? 12.h : 8.h),
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                    )),
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    textAlign: TextAlign.start,
                    text: duration,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(AppImages.profile1), // Using the specified asset
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.sentiment_satisfied, color: Colors.blue, size: 20.sp),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type message...',
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.mic, color: Colors.blue, size: 20.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue, size: 20.sp),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}