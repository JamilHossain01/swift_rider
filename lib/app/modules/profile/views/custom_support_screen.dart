import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

class CustomerSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/speaker_icon.png', // Replace with your speaker icon asset
          height: 24,
          width: 24,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp, // Slightly larger for title
              textAlign: TextAlign.start,
              text: 'Customer Support',
              color: AppColors.authTextColor,
            ),
            CustomText(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              textAlign: TextAlign.start,
              text: 'Online',
              color: Colors.green, // Green for "Online" status
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/call_icon.png', // Replace with your call icon asset
              height: 24,
              width: 24,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/speaker_icon.png', // Replace with your speaker icon asset
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 8),
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
                              text: 'Have a great working week!!',
                              color: AppColors.authTextColor,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: 'Hope you like it',
                              color: AppColors.authTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:10 PM',
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // User Message 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:11 PM',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
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
                              'assets/waveform.png', // Replace with your waveform asset
                              height: 20,
                              width: 60,
                            ),
                            SizedBox(width: 8),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: '00:16',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/profile_image.png', // Replace with your profile image asset
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Support Message 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/speaker_icon.png', // Replace with your speaker icon asset
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 8),
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
                              text: 'Have a great working week!!',
                              color: AppColors.authTextColor,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: 'Hope you like it',
                              color: AppColors.authTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:12 PM',
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // User Message 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:14 PM',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
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
                              'assets/waveform.png', // Replace with your waveform asset
                              height: 20,
                              width: 60,
                            ),
                            SizedBox(width: 8),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: '00:16',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/profile_image.png', // Replace with your profile image asset
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Support Message 3
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/speaker_icon.png', // Replace with your speaker icon asset
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 8),
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
                              text: 'Have a great working week!!',
                              color: AppColors.authTextColor,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: 'Hope you like it',
                              color: AppColors.authTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:15 PM',
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // User Message 3
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      textAlign: TextAlign.end,
                      text: '01:14 PM',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
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
                              'assets/waveform.png', // Replace with your waveform asset
                              height: 20,
                              width: 60,
                            ),
                            SizedBox(width: 8),
                            CustomText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                              text: '00:16',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/profile_image.png', // Replace with your profile image asset
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Input Field
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.sentiment_satisfied, color: Colors.blue),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}