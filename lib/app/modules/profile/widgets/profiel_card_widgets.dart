import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final LinearGradient gradient;
  final String number;
  final String holder;
  final String expiry;
  CardWidget({
    required this.gradient,
    required this.number,
    required this.holder,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.credit_card, color: Colors.white),
          ),
          const Spacer(),
          Text(
            number,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card Holder\n$holder",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              Text(
                "Expired Date\n$expiry",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
