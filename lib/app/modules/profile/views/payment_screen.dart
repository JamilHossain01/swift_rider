import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/home_screen_app_bar.dart';
import '../widgets/profiel_card_widgets.dart';
import '../widgets/transaction_widgets.dart';
import 'add_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeCustomAppBar(title: 'Payment'),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Card List",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => AddCardScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 180.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardWidget(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFc2e59c), Color(0xFF64b3f4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    number: "8763 2736 9873 0329",
                    holder: "Ronald Richards",
                    expiry: "10/28",
                  ),
                  SizedBox(width: 12.w),
                  CardWidget(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFee9ca7), Color(0xFFffdde1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    number: "8763 2736 9873 0329",
                    holder: "Marvin McKinney",
                    expiry: "08/25",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Transaction History",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TransactionItemWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


