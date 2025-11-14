import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import 'dashed_line_wigets.dart';

class RideLocationSection extends StatelessWidget {
  final String title;
  final String location;
  final String? airline;
  final String? flightCode;
  final String? dateTime;
  final bool isPickup;

  const RideLocationSection({
    Key? key,
    required this.title,
    required this.location,
    this.airline,
    this.flightCode,
    this.dateTime,
    this.isPickup = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2.w),
              ),
              child: Center(
                child: Icon(
                  isPickup ? Icons.circle : Icons.location_on,
                  size: 16.sp,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF475467),
            ),
            const Spacer(),
            if (dateTime != null)
              CustomText(
                text: 'Date & Time: $dateTime',
                fontSize: 12.sp,
                color: Color(0xFF475467),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomText(
          text: location,
          fontSize: 14.sp,
          color: Color(0xFF1D2939),

        ),
        if (airline != null || flightCode != null)
          Row(
            children: [
              Icon(Icons.flight, size: 16.sp),
              SizedBox(width: 8.w),
              if (airline != null)
                CustomText(
                  text: airline!,
                  color: Color(0xFF1D2939),

                  fontSize: 14.sp,
                ),
              if (flightCode != null)
                CustomText(
                  text: flightCode!,
                  color: Color(0xFF1D2939),

                  fontSize: 14.sp,
                ),
              if (dateTime != null && (airline == null || flightCode == null))
                CustomText(
                  text: dateTime!,
                  fontSize: 14.sp,
                  color: Color(0xFF1D2939),

                ),
            ],
          ),
        // if (!isPickup)
        //   SizedBox(height: 16.h),
        // if (!isPickup)
        //   Padding(
        //     padding: EdgeInsets.only(left: 16.w),
        //     child: DashedLine(),
        //   ),
      ],
    );
  }
}