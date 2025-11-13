import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../wigest/ride_location_section_wigets.dart';
import '../wigest/dashed_line_wigets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common widget/home_screen_app_bar.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';


class RideRequestBottomSheet extends StatefulWidget {
  final VoidCallback onAccept; // Callback for Accept button

  const RideRequestBottomSheet({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  @override
  _RideRequestBottomSheetState createState() => _RideRequestBottomSheetState();
}

class _RideRequestBottomSheetState extends State<RideRequestBottomSheet> {
  // Ride data integrated as a class-level variable
  final Map<String, dynamic> rideRequest = {
    'driverName': 'Jenny Wilson',
    'distance': '10.2 km',
    'cost': '\$256.0',
    'orderType': 'To the airport (Oneway)',
    'passengerCount': 4,
    'tripNotes': 'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'internalComments': 'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'pickup': 'Lax-los angeles international airport\nAmerican Airlines\nAA 3',
    'time': '03:33 PM +06, Monday, September 08, 2025', // Updated to current date/time
    'dropoff': '8502 Preston Rd. Inglewood, Maine 98380',
    'airline': 'American Airlines',
    'flightCode': 'AA 3',
    'carryOn': 2,
    'checked': 2,
    'oversize': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Ride Request'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
        },
        child:
        Container(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: const NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: rideRequest['driverName'] ?? 'Driver Name Not Available',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'Isahmed739@gmail.com',
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomText(
                          text: rideRequest['distance'] ?? '10km',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        CustomText(
                          text: rideRequest['cost'] ?? '\$250',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                buildInfoRow('Order Type', rideRequest['orderType'] ?? 'Order Type Not Available'),
                buildInfoRow('Trip Type', 'Hourly'),
                buildInfoRow('Passenger Count', rideRequest['passengerCount'].toString() ?? '4'),
                CustomText(
                  text: 'Trip Notes',
                  fontSize: 14.sp,
                  color: AppColors.btmShift6Color,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: rideRequest['tripNotes'] ?? 'No trip notes available.',
                  fontSize: 12.sp,
                  color: AppColors.btmShift6Color,
                ),
                CustomText(
                  text: 'Luggage',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5C5C5C),
                ),
                buildLuggageRow('Carry-on', rideRequest['carryOn'].toString()),
                buildLuggageRow('Checked', rideRequest['checked'].toString()),
                buildLuggageRow('Oversize', rideRequest['oversize'].toString()),
                CustomText(
                  text: 'Internal Comments',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C5C5C),
                ),
                CustomText(
                  color: Color(0xFF595959),
                  textAlign: TextAlign.start,
                  text: rideRequest['internalComments'] ?? 'No internal comments.',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.h),
                RideLocationSection(
                  title: 'Pick up point',
                  location: rideRequest['pickup'] ?? 'Pickup location not available.',
                  airline: rideRequest['airline'] ?? 'Airline not available.',
                  flightCode: rideRequest['flightCode'] ?? 'Flight code not available.',
                  dateTime: rideRequest['time'] ?? 'Time not available.',
                  isPickup: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: DashedLine(),
                ),
                RideLocationSection(
                  title: 'Pick Off',
                  location: rideRequest['dropoff'] ?? 'Dropoff location not available.',
                  isPickup: false,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget(
                        btnColor: Colors.white,
                        borderColor: Color(0xFF5C5C5C),
                        btnText: 'Decline',
                        btnTextColor: Color(0xFF1D2939),
                        onTap: () => Navigator.pop(context),
                        iconWant: false,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: CustomButtonWidget(
                        btnColor: AppColors.blueToggle,
                        btnTextColor: Colors.white,
                        btnText: 'Accept',
                        onTap: () {
                          widget.onAccept(); // Call the callback to update state
                          Navigator.pop(context); // Close the bottom sheet
                          Get.offNamed('/history'); // Navigate to HistoryView
                        },
                        iconWant: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build rows of info
  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          color: AppColors.btmShift6Color,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: value,
          fontSize: 14.sp,
          color: AppColors.blueToggle,
        ),
      ],
    );
  }

  // Helper method to build luggage rows
  Widget buildLuggageRow(String type, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: type,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.btmShift6Color,
        ),
        CustomText(
          text: count,
          fontSize: 14.sp,
          color: AppColors.blueToggle,
        ),
      ],
    );
  }
}