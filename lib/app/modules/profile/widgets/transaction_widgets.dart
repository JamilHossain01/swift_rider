import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Color(0xFFF2F4F7),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Saturday, 12/12/2024, 05:41 PM",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              Text("\$52.90",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(Icons.circle, size: 12, color: Colors.blue),
              SizedBox(width: 6.w),
              Expanded(
                child: Text("6391 Elgin St. Delaware 10299",
                    style: TextStyle(fontSize: 12.sp)),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.red),
              SizedBox(width: 6.w),
              Expanded(
                child: Text("8502 Preston, Inglewood, Maine",
                    style: TextStyle(fontSize: 12.sp)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundImage: const NetworkImage(
                    "https://randomuser.me/api/portraits/men/44.jpg"),
              ),
              SizedBox(width: 6.w),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text("(4.8)", style: TextStyle(fontSize: 12.sp)),
            ],
          )
        ],
      ),
    );
  }
}
