import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_ride/app/modules/driver_home_view/views/rider_request_view.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_ride/app/modules/driver_home_view/views/rider_request_view.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_ride/app/modules/driver_home_view/views/rider_request_view.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';

class MapScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const MapScreen({super.key, this.initialLat, this.initialLng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(23.8041, 90.4152), // Default: Dhaka
    zoom: 15,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];

  Position? _currentPosition;
  late GoogleMapController _mapController;

  bool isOnline = false; // Driver starts offline
  int notificationCount = 1;

  // Ride Flow States
  bool rideAccepted = false;
  bool rideStarted = false;
  bool rideFinished = false;

  // Control bottom sheet visibility
  bool _showPolylineAndBottomSheet = false;
  bool _showHistoryBottomSheet = false; // Flag for history navigation

  // Pickup & Drop Locations (dummy)
  final LatLng pickupLatLng = const LatLng(23.8041, 90.4152); // Dhaka
  final LatLng dropLatLng = const LatLng(23.8103, 90.4125); // Nearby location

  // Ride Data (aligned with RideRequestBottomSheet and history)
  final Map<String, dynamic> rideRequest = {
    'driverName': 'Jenny Wilson',
    'distance': '10.2 km',
    'cost': '\$256.0',
    'orderType': 'To the airport (Oneway)',
    'tripType': 'Hourly',
    'passengerCount': 4,
    'tripNotes':
    'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'internalComments':
    'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'pickup': 'Lax-los angeles international airport\nAmerican Airlines\nAA 3',
    'time': '07:15 - 25 4:50PM',
    'dropoff': '8502 Preston Rd. Inglewood, Maine 98380',
    'airline': 'American Airlines',
    'flightCode': 'AA 3',
    'carryOn': 2,
    'checked': 2,
    'oversize': 2,
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setupMarkers();
    // Update initial position if initialLat and initialLng are provided
    if (widget.initialLat != null && widget.initialLng != null) {
      _initialPosition = CameraPosition(
        target: LatLng(widget.initialLat!, widget.initialLng!),
        zoom: 15,
      );
      _showHistoryBottomSheet = true; // Show history bottom sheet on navigation
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied forever.")),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        // Only update position if no initialLat/initialLng provided
        if (widget.initialLat == null && widget.initialLng == null) {
          _initialPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          );
        }
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Move camera to initial position when map is created
    if (widget.initialLat != null && widget.initialLng != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(widget.initialLat!, widget.initialLng!), 15),
      );
    }
  }

  void _setupMarkers() {
    _markers.add(
      Marker(
        markerId: const MarkerId("pickup"),
        position: pickupLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId("dropoff"),
        position: dropLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ),
    );
  }

  void _getPolyline() {
    polylineCoordinates = [
      pickupLatLng,
      const LatLng(23.8060, 90.4160), // Mid point 1
      const LatLng(23.8080, 90.4140), // Mid point 2
      dropLatLng,
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          width: 4,
          color: Colors.black,
          points: polylineCoordinates,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            markers: _markers,
            polylines: _polylines,
            onMapCreated: _onMapCreated,
          ),

          // Top bar with Online switch
          Positioned(
            top: 50.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage(AppImages.men1),
                    ),
                    const SizedBox(width: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Online',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            Switch(
                              value: isOnline,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                setState(() {
                                  isOnline = val;
                                  if (isOnline) {
                                    Timer(const Duration(seconds: 3), () {
                                      _getPolyline();
                                      setState(() {
                                        _showPolylineAndBottomSheet = true;
                                        _showHistoryBottomSheet = false; // Disable history sheet when going online
                                      });
                                    });
                                  } else {
                                    setState(() {
                                      _showPolylineAndBottomSheet = false;
                                      _polylines.clear();
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications, size: 28.0),
                        onPressed: () => setState(() => notificationCount = 0),
                      ),
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: 8.0,
                        top: 8.0,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$notificationCount",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Existing Bottom Sheet (shown when online)
          if (_showPolylineAndBottomSheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => RideRequestBottomSheet(
                    onAccept: () {
                      setState(() {
                        rideAccepted = true;
                      });
                      Get.back();
                    },
                  ));
                },
                child: Container(
                  height: 100.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
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
                                      text: rideRequest['driverName'] ??
                                          'Driver Name Not Available',
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // History Bottom Sheet (shown on navigation from HistoryCard)
          if (_showHistoryBottomSheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 400.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
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
                                      text: 'Isahmed739@gmail.com\n+880 1234 567819',
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
                                  text: rideRequest['cost'] ?? '\$256.0',
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        CustomText(
                          text: 'Order Type',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        CustomText(
                          text: rideRequest['orderType'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: 'Trip Type',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        CustomText(
                          text: rideRequest['tripType'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: 'Passenger Count',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        CustomText(
                          text: '${rideRequest['passengerCount'] ?? 0}',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: 'Trip Notes',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        CustomText(
                          text: rideRequest['tripNotes'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: 'Luggage',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: 'Carry-on: ${rideRequest['carryOn'] ?? 0}',
                              fontSize: 14.sp,
                              color: AppColors.hTitleColor,
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: 'Checked: ${rideRequest['checked'] ?? 0}',
                              fontSize: 14.sp,
                              color: AppColors.hTitleColor,
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: 'Oversize: ${rideRequest['oversize'] ?? 0}',
                              fontSize: 14.sp,
                              color: AppColors.hTitleColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: 'Internal Comments',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hTitleColor,
                        ),
                        CustomText(
                          text: rideRequest['internalComments'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            const Icon(Icons.circle, size: 12, color: Colors.blue),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: 'Pickup point',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.hTitleColor,
                            ),
                            CustomText(
                              text: ' Date & Time: ${rideRequest['time'] ?? 'N/A'}',
                              fontSize: 14.sp,
                              color: AppColors.hTitleColor,
                            ),
                          ],
                        ),
                        CustomText(
                          text: rideRequest['pickup'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.blue),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: 'Pick Off',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.hTitleColor,
                            ),
                          ],
                        ),
                        CustomText(
                          text: rideRequest['dropoff'] ?? 'N/A',
                          fontSize: 14.sp,
                          color: AppColors.hTitleColor,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  _showHistoryBottomSheet = false;
                                  rideAccepted = true;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat, color: Colors.blue),
                              onPressed: () {
                                // Add chat functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.phone, color: Colors.blue),
                              onPressed: () {
                                // Add call functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                              onPressed: () {
                                // Add navigation or next step functionality
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Ride Flow (Arrived / Start Trip)
          if (rideAccepted && !rideStarted)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RideActionSheet(
                name: rideRequest["driverName"]!,
                distance: rideRequest["distance"]!,
                price: rideRequest["cost"]!,
                buttonText: "Arrived",
                onTap: () => setState(() => rideStarted = true),
                isAccepted: true,
              ),
            ),
          // Finish Trip
          if (rideStarted && !rideFinished)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RideActionSheet(
                name: rideRequest["driverName"]!,
                distance: rideRequest["distance"]!,
                price: rideRequest["cost"]!,
                buttonText: "Finish Trip",
                onTap: () => setState(() => rideFinished = true),
                isAccepted: false,
              ),
            ),
        ],
      ),
    );
  }
}

// ================= Ride Action Sheet =================
class RideActionSheet extends StatelessWidget {
  final String name;
  final String distance;
  final String price;
  final String buttonText;
  final VoidCallback onTap;
  final bool isAccepted;

  const RideActionSheet({
    super.key,
    required this.name,
    required this.distance,
    required this.price,
    required this.buttonText,
    required this.onTap,
    this.isAccepted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/user.png"),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "User",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      distance,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (isAccepted) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Arrived marked")),
                  );
                },
                child: const Text("Arrived"),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: onTap,
                child: const Text(
                  "Tap To Start Trip",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ] else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: onTap,
                child: Text(buttonText),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= Ride Action Sheet =================
// class RideActionSheet extends StatelessWidget {
//   final String name;
//   final String distance;
//   final String price;
//   final String buttonText;
//   final VoidCallback onTap;
//
//   const RideActionSheet({
//     super.key,
//     required this.name,
//     required this.distance,
//     required this.price,
//     required this.buttonText,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const CircleAvatar(
//               backgroundImage: AssetImage("assets/user.png"),
//             ),
//             title: Text(name),
//             subtitle: Text(distance),
//             trailing: Text(
//               price,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               minimumSize: const Size(double.infinity, 50),
//             ),
//             onPressed: onTap,
//             child: Text(buttonText),
//           ),
//         ],
//       ),
//     );
//   }
// }

