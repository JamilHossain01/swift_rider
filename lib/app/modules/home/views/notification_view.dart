import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common%20widget/home_screen_app_bar.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../wigets/notification_card.dart'; // Import your AppImages class

class NotificationView extends StatelessWidget {
   NotificationView({super.key});

  // Sample notification data
  final List<Map<String, String>> notifications = [
    {
      'title': 'Promotion',
      'subtitle': 'Invite friends - you got 25 gift!',
      'timeAgo': '1 min ago',
      'icon': AppImages.cupon,
    },
    {
      'title': 'New payment method',
      'subtitle': 'Thank you! your transaction is ...',
      'timeAgo': '10 mins ago',
      'icon': AppImages.masterCard,
    },
    {
      'title': 'System',
      'subtitle': 'Thank you! your transaction is ...',
      'timeAgo': '14 h ago',
      'icon': AppImages.sNoti,
    },
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: HomeCustomAppBar(title: 'Notification'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title for the section
            CustomText(
              text: "Today",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 16.h),
            // List of notifications using ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return NotificationCard(
                    title: notification['title']!,
                    subtitle: notification['subtitle']!,
                    timeAgo: notification['timeAgo']!,
                    iconPath: notification['icon']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
