import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class TopBar extends StatelessWidget {
  final bool isOnline;
  final Function toggleOnline;
  final int notificationCount;
  final Function clearNotifications;

  const TopBar({
    Key? key,
    required this.isOnline,
    required this.toggleOnline,
    required this.notificationCount,
    required this.clearNotifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
                  ),
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'van Houten',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: isOnline ? 'Online' : 'Offline',
                          color: isOnline ? Colors.green : Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                        ),
                        Switch(
                          value: isOnline,
                          onChanged: (value) => toggleOnline(),
                          activeColor: Colors.blue,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () => clearNotifications(),
                  child: IconButton(
                    icon: Icon(Icons.notifications, color: Colors.grey.shade700),
                    onPressed: () {},
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: CustomText(
                        text: notificationCount.toString(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}