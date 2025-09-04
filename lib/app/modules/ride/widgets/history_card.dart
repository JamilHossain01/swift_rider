import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../views/ride_map_view.dart'; // <-- import your map screen

class HistoryCard extends StatefulWidget {
  final String title;
  final String address;
  final String date;
  final String driver;
  final bool isConfirmed;
  final String time;
  final String distance;
  final double lat;
  final double lng;

  const HistoryCard({
    super.key,
    required this.title,
    required this.address,
    required this.date,
    required this.driver,
    required this.isConfirmed,
    required this.time,
    required this.distance,
    required this.lat,
    required this.lng,
  });

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool _isMapVisible = false; // To control the visibility of the map

  void toggleMapVisibility() {
    setState(() {
      _isMapVisible = !_isMapVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: widget.title,
                  color: AppColors.hTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                GestureDetector(
                  onTap: toggleMapVisibility, // Toggle map visibility on tap
                  child: Image.asset(
                    _isMapVisible ? AppImages.downArrow : AppImages.topArrow, // Toggle between down and up arrows
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // Address
            CustomText(
              textAlign: TextAlign.start,
              text: widget.address,
              color: AppColors.hTitleColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            SizedBox(height: 6.h),

            // Date
            CustomText(
              textAlign: TextAlign.start,
              text: widget.date,
              color: AppColors.hTitleColor,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),

            // Driver confirmation
            if (widget.isConfirmed) ...[
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Driver: ",
                    color: AppColors.hTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7FFE9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.greenTick,
                          height: 12.h,
                        ),
                        SizedBox(width: 5.w),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: "Confirmed",
                          color: const Color(0xFF00C01F),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 10.h),

            // Conditionally show map or text
            if (_isMapVisible)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RideMapScreen(lat: widget.lat, lng: widget.lng),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 150.h,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.lat, widget.lng),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(widget.title),
                          position: LatLng(widget.lat, widget.lng),
                        ),
                      },
                      zoomControlsEnabled: false,
                      liteModeEnabled: true,
                    ),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: 'Address: ${widget.address}',
                    color: AppColors.hTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: 'Date: ${widget.date}',
                    color: AppColors.hTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: 'Driver: ${widget.driver}',
                    color: AppColors.hTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            SizedBox(height: 10.h),

            // Time & Distance
            Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.black54),
                    SizedBox(width: 4.w),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: widget.time,
                      color: const Color(0xFF475467),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                Row(
                  children: [
                    const Icon(Icons.map, size: 16, color: Colors.black54),
                    SizedBox(width: 4.w),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: widget.distance,
                      color: const Color(0xFF475467),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
