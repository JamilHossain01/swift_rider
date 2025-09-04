import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_ride/app/common%20widget/custom_button_widget.dart';
import 'package:swift_ride/app/modules/driver_home_view/wigest/dashed_line_wigets.dart';
import 'package:swift_ride/app/modules/home/views/notification_view.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../wigest/ride_location_section_wigets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(0, 0);
  bool _isOnline = true;
  int _notificationCount = 5;
  bool _isLoading = true;
  String _locationError = '';

  // Sample taxi locations around the user
  final List<LatLng> _taxiLocations = [];

  // Sample ride request data
  final Map<String, dynamic> _rideRequest = {
    'driverName': 'Jenny Wilson',
    'distance': '10.2 km',
    'cost': '\$256.0',
    'orderType': 'To the airport (Oneway)',
    'passengerCount': 4,
    'pickup': 'B802 Preston Rd, Ingleswood, Maine 03830',
    'dropoff': 'Lax-los angeles international airport',
    'airline': 'American Airlines',
    'time': '07:24 - 4:50 PM',
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        setState(() {
          _locationError = 'Location permission denied';
          _isLoading = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      _generateTaxiLocations();
    } catch (e) {
      setState(() {
        _locationError = 'Error getting location: $e';
        _isLoading = false;
      });
    }
  }

  void _generateTaxiLocations() {
    _taxiLocations.clear();
    for (int i = 0; i < 8; i++) {
      final double offsetLat = (math.Random().nextDouble() - 0.5) * 0.02;
      final double offsetLng = (math.Random().nextDouble() - 0.5) * 0.02;
      _taxiLocations.add(LatLng(
        _currentLocation.latitude + offsetLat,
        _currentLocation.longitude + offsetLng,
      ));
    }
    setState(() {});
  }

  void _refreshTaxis() {
    _generateTaxiLocations();
  }

  void _toggleOnline() {
    setState(() {
      _isOnline = !_isOnline;
    });
  }

  void _clearNotifications() {
    Get.to(()=>NotificationView());
    setState(() {
      _notificationCount = 0;
    });
  }

  void _centerOnUser() {
    _mapController.move(_currentLocation, 15.0);
  }

  void _showRideRequest() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h),
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
                            text: _rideRequest['driverName'],
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
                        text: _rideRequest['distance'],
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: _rideRequest['cost'],
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Order Type',
                    fontSize: 14.sp,
                    color: AppColors.btmShift6Color,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: _rideRequest['orderType'],
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Trip Type',
                    fontSize: 14.sp,
                    color: AppColors.btmShift6Color,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: 'Hourly',
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Passenger Count',
                    fontSize: 14.sp,
                    color: AppColors.btmShift6Color,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: '4',
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              CustomText(
                text: 'Trip Notes',
                fontSize: 14.sp,
                color: AppColors.btmShift6Color,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                textAlign: TextAlign.start,
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                fontSize: 12.sp,
                color: AppColors.btmShift6Color,
              ),
              CustomText(
                text: 'Luggage',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5C5C5C),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Carry-on',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.btmShift6Color,
                  ),
                  CustomText(
                    text: '4',
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Checked',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.btmShift6Color,
                  ),
                  CustomText(
                    text: '4',
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Oversize',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.btmShift6Color,
                  ),
                  CustomText(
                    text: '4',
                    fontSize: 14.sp,
                    color: AppColors.blueToggle,
                  ),
                ],
              ),
              CustomText(
                text: 'Internal Comments',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C5C5C),
              ),
              CustomText(
                color: Color(0xFF595959),
                textAlign: TextAlign.start,
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h),
              RideLocationSection(
                title: 'Pick up point',
                location: 'Lax-los angeles international airport',
                airline: 'American Airlines',
                flightCode: 'AA 3',
                dateTime: '07-15-25 4:50PM',
                isPickup: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: DashedLine(),
              ),
              RideLocationSection(
                title: 'Pick Off',
                location: '8502 Preston Rd. Ingleswood, Maine 98380',
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
                  SizedBox(width: 20.w,),


                  Expanded(
                    child: CustomButtonWidget(
                      btnColor: AppColors.blueToggle,
                      btnTextColor: Colors.white,
                      btnText: 'Accept',
                      onTap: () => Navigator.pop(context),
                      iconWant: false,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _locationError.isNotEmpty
              ? Center(
                  child: CustomText(
                  text: _locationError,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                ))
              : Stack(
                  children: [
                    // Map
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _currentLocation,
                        zoom: 15.0,
                        maxZoom: 18.0,
                        minZoom: 10.0,
                        onTap: (_, __) =>
                            _showRideRequest(), // Trigger bottom sheet on map tap
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            // User location marker
                            Marker(
                              point: _currentLocation,
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.blue.shade700,
                                size: 50,
                              ),
                            ),
                            // Taxi markers
                            ..._taxiLocations.map((location) {
                              return Marker(
                                point: location,
                                width: 40,
                                height: 40,
                                child: GestureDetector(
                                  onTap: _showRideRequest,
                                  child: Icon(
                                    Icons.local_taxi,
                                    color: Colors.yellow.shade700,
                                    size: 40,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                    ),

                    // Top Bar with Profile and Online Toggle
                    Positioned(
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
                                      text: 'Jenny Wilson',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      textAlign: TextAlign.start,
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text:
                                              _isOnline ? 'Online' : 'Offline',
                                          color: _isOnline
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.sp,
                                          textAlign: TextAlign.start,
                                        ),
                                        Switch(
                                          value: _isOnline,
                                          onChanged: (value) => _toggleOnline(),
                                          activeColor: Colors.blue,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
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

                                  child: IconButton(
                                    icon: Icon(Icons.notifications,
                                        color: Colors.grey.shade700),
                                    onPressed: _clearNotifications,
                                  ),
                                ),
                                if (_notificationCount > 0)
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
                                        text: _notificationCount.toString(),
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
                    ),

                    // Bottom Navigation Bar
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.my_location,
                                    color: Colors.blue.shade700),
                                onPressed: _centerOnUser,
                              ),
                              IconButton(
                                icon: Icon(Icons.refresh,
                                    color: Colors.grey.shade700),
                                onPressed: _refreshTaxis,
                              ),
                              IconButton(
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.blue.shade700),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.person,
                                    color: Colors.grey.shade700),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
