import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String initials;

  const ContactCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(
                text: "Booking / Billing Contact",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
              Image.asset(AppImages.deleteCard,height: 24,width: 24,),
            ],
          ),

          SizedBox(height: 8.h),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(initials),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  CustomText(
                    text: email,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  CustomText(
                    text: phone,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

        ],
      ),
    );
  }
}
