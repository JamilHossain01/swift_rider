import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';


// Reusable Transaction Card Widget
class TransactionCard extends StatelessWidget {
  final String name;
  final String distance;
  final String amount;
  final String dateTime;
  final bool isWithdrawal;
  final String? withdrawalIconAsset; // Path to withdrawal icon asset
  final String regularIconAsset; // Path to regular transaction icon asset

  const TransactionCard({
    Key? key,
    required this.name,
    required this.distance,
    required this.amount,
    required this.dateTime,
    this.isWithdrawal = false,
    this.withdrawalIconAsset = 'assets/images/spending 1.png', // Default withdrawal icon
    this.regularIconAsset = 'assets/images/2.png', // Default regular icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Section (Icon and Details)
          Row(
            children: [
              Image.asset(
                isWithdrawal ? withdrawalIconAsset! : regularIconAsset,
                width: 24.w,
                height: 24.w,
                color: isWithdrawal ? Colors.red : Colors.blue,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: isWithdrawal ? 'Balance Withdraw' : name,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isWithdrawal ? Colors.black : Colors.black,
                  ),
                  CustomText(
                    text: dateTime,
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                  if (!isWithdrawal)
                    CustomText(
                      text: distance,
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                ],
              ),
            ],
          ),
          // Right Section (Amount)
          CustomText(
            text: isWithdrawal ? '−$amount' : '+${amount}',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: isWithdrawal ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }
}

