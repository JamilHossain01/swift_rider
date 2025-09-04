import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/driver_wallet_controller.dart';
import '../widgets/transcation_card.dart';

class DriverWalletView extends GetView<DriverWalletController> {
   DriverWalletView({super.key});

  // List of transaction data
  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Esther Howard',
      'distance': '15.6 km',
      'amount': '\$253.0',
      'dateTime': 'Today at 09:20 am, Sep 04, 2025',
      'isWithdrawal': false,
    },
    {
      'name': 'Balance Withdraw',
      'amount': '\$1256.0',
      'dateTime': 'Yesterday at 09:20 am, Sep 03, 2025',
      'isWithdrawal': true,
      'withdrawalIconAsset': 'assets/images/spending 1.png',
    },
    {
      'name': 'Theresa Webb',
      'distance': '15.6 km',
      'amount': '\$253.0',
      'dateTime': 'Yesterday at 09:20 am, Sep 03, 2025',
      'isWithdrawal': false,
    },
    {
      'name': 'Jacob Jones',
      'distance': '15.6 km',
      'amount': '\$253.0',
      'dateTime': 'Yesterday at 09:20 am, Sep 03, 2025',
      'isWithdrawal': false,
    },
    {
      'name': 'Leslie Alexander',
      'distance': '15.6 km',
      'amount': '\$252.0',
      'dateTime': 'Yesterday at 09:20 am, Sep 03, 2025',
      'isWithdrawal': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Wallet'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Life Time Income Section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF3FF),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.blueToggle.withOpacity(0.20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Life Time Income',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                          color: const Color(0xFF475467),
                        ),
                        CustomText(
                          text: '\$5,203,251.00',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          textAlign: TextAlign.start,
                          color: const Color(0xFF1D2939),
                        ),
                      ],
                    ),
                    Image.asset(
                      AppImages.medal,
                      width: 51.w,
                      height: 48.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Today Income and Total Trip Sections
              Row(
                children: [
                  // Today Income
                  Expanded(
                    child: Container(
                      height: 110.h,
                      width: 155.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3FF),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.blueToggle.withOpacity(0.20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Today Income',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                            color: const Color(0xFF475467),
                          ),
                          CustomText(
                            text: '\$5,203.0',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            textAlign: TextAlign.start,
                            color: const Color(0xFF1D2939),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Total Trip
                  Expanded(
                    child: Container(
                      height: 110.h,
                      width: 155.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3FF),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.blueToggle.withOpacity(0.20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Total Trip',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                            color: const Color(0xFF475467),
                          ),
                          CustomText(
                            text: '652',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            textAlign: TextAlign.start,
                            color: const Color(0xFF1D2939),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h), // Added spacing before transaction list
              // Transaction List
              ListView.builder(
                shrinkWrap: true, // Ensures it fits within SingleChildScrollView
                physics: NeverScrollableScrollPhysics(), // Prevents inner scrolling
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionCard(
                    name: transaction['name'],
                    distance: transaction['distance'] ?? '',
                    amount: transaction['amount'],
                    dateTime: transaction['dateTime'],
                    isWithdrawal: transaction['isWithdrawal'] ?? false,
                    withdrawalIconAsset: transaction['withdrawalIconAsset'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}