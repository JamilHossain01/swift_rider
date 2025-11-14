import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swift_ride/app/common%20widget/home_screen_app_bar.dart';
import 'package:swift_ride/app/modules/driver_home_view/wigest/dashed_line_wigets.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../driver_ride/widgets/row_item_conatiner.dart';

enum RideState { arriving, coming, started, rating, finished }



class RideTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> rideData;

  const RideTrackingScreen({super.key, required this.rideData});

  @override
  State<RideTrackingScreen> createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  late GoogleMapController _mapController;
  RideState rideState = RideState.arriving;
  Timer? _rideTimer;
  int _elapsedTime = 0;
  double _rating = 0.0;

  late LatLng pickupLatLng;
  late LatLng dropoffLatLng;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setupMapData();
    _setupMarkersAndPolyline();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.rideData['isPast'] == true && rideState != RideState.rating) {
      rideState = RideState.rating;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showRatingDialog();
      });
    }
  }

  void _setupMapData() {
    pickupLatLng = LatLng(
      widget.rideData['pickup']['lat'] ?? 37.42796,
      widget.rideData['pickup']['lng'] ?? -122.08575,
    );
    dropoffLatLng = LatLng(
      widget.rideData['dropoff']['lat'] ?? 37.43296,
      widget.rideData['dropoff']['lng'] ?? -122.08832,
    );
  }

  void _setupMarkersAndPolyline() {
    _markers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: pickupLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: widget.rideData['pickup']['address'] ?? 'Pickup'),
    ));
    _markers.add(Marker(
      markerId: const MarkerId('dropoff'),
      position: dropoffLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: widget.rideData['dropoff']['address'] ?? 'Dropoff'),
    ));
    _markers.add(Marker(
      markerId: const MarkerId('driver'),
      position: pickupLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: '${widget.rideData['driver']} - ${widget.rideData['car']}'),
    ));

    _polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: [pickupLatLng, dropoffLatLng],
      color: Colors.blue,
      width: 5,
    ));
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        [pickupLatLng.latitude, dropoffLatLng.latitude].reduce((a, b) => a < b ? a : b) - 0.01,
        [pickupLatLng.longitude, dropoffLatLng.longitude].reduce((a, b) => a < b ? a : b) - 0.01,
      ),
      northeast: LatLng(
        [pickupLatLng.latitude, dropoffLatLng.latitude].reduce((a, b) => a > b ? a : b) + 0.01,
        [pickupLatLng.longitude, dropoffLatLng.longitude].reduce((a, b) => a > b ? a : b) + 0.01,
      ),
    );
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  void _startRideTimer() {
    _rideTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _elapsedTime++);
    });
  }

  String _formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: 'Cancel Trip', fontSize: 20.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 16.h),
              CustomText(
                text: 'Please select the reason for cancellation:',
                fontSize: 16.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 16.h),
              Row(children: [
                Checkbox(value: false, onChanged: (_) {}),
                CustomText(text: 'Waiting for long time', fontSize: 14.sp),
              ]),
              Row(children: [
                Checkbox(value: true, onChanged: (_) {}),
                CustomText(text: 'Wrong address shown', fontSize: 14.sp),
              ]),
              Row(children: [
                Checkbox(value: false, onChanged: (_) {}),
                CustomText(text: 'The price is not reasonable', fontSize: 14.sp),
              ]),
              Row(children: [
                Checkbox(value: false, onChanged: (_) {}),
                CustomText(text: "Ride isn't here", fontSize: 14.sp),
              ]),
              Row(children: [
                Checkbox(value: false, onChanged: (_) {}),
                CustomText(text: 'Others', fontSize: 14.sp),
              ]),
              SizedBox(height: 20.h),
              CustomButtonWidget(
                iconWant: false,
                btnText: 'Submit Reason',
                onTap: () {
                  Navigator.pop(context);
                  Get.back();
                },
                btnColor: AppColors.mainColor,
                btnTextColor: Colors.white,
                btnTextSize: 16.sp,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: 'Thank you! 😊', fontSize: 20.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 8.h),
              CustomText(
                text: 'Please rate your trip',
                fontSize: 16.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 16.h),
              CircleAvatar(
                radius: 40.r,
                backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
              ),
              SizedBox(height: 8.h),
              CustomText(text: 'Jenny Wilson', fontSize: 16.sp, fontWeight: FontWeight.bold),
              CustomText(text: 'Driver', fontSize: 14.sp, color: Colors.grey),
              SizedBox(height: 8.h),
              CustomText(text: widget.rideData['distance'], fontSize: 14.sp),
              CustomText(text: widget.rideData['cost'], fontSize: 16.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 16.h),
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) => _rating = rating,
                    glow: true,
                  ),
                  CustomText(
                    text: '(4.8)',
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomButtonWidget(
                iconWant: false,
                btnText: 'Submit',
                onTap: () {
                  Navigator.pop(context);
                  setState(() => rideState = RideState.finished);
                  Get.back();
                },
                btnColor: AppColors.mainColor,
                btnTextColor: Colors.white,
                btnTextSize: 16.sp,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showStartRideDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  //       title: CustomText(
  //         text: 'Start Ride?',
  //         fontSize: 20.sp,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       content: CustomText(
  //         text: 'Are you sure you want to start the ride with ${widget.rideData['driver']}?',
  //         fontSize: 16.sp,
  //         color: Colors.grey,
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: CustomText(text: 'Cancel', fontSize: 16.sp, color: AppColors.blueToggle),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             setState(() {
  //               rideState = RideState.started;
  //             });
  //             _startRideTimer();
  //           },
  //           child: CustomText(text: 'Start', fontSize: 16.sp, color: AppColors.blueToggle),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void _showStartRideDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                // Profile row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/44.jpg'),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: widget.rideData['driver'] ?? 'Arlene McCoy',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  CustomText(
                                    text: '(4.8)',
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: widget.rideData['car'] ?? 'Ford Consul Cortina',
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: '${widget.rideData['distance'] ?? '200m'}',
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Pickup Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.radio_button_checked, color: Colors.blue, size: 18.r),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Pickup point',
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                          CustomText(
                            text: widget.rideData['pickup']['address'] ?? '6391 Elgin St. Celina, Delaware 10299',
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                DashedLine(),
                SizedBox(height: 8.h),


                // Dropoff Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.black54, size: 18.r),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Pick Off',
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                          CustomText(
                            text: widget.rideData['dropoff']['address'] ?? '8502 Preston Rd. Inglewood, Maine 98380',
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Booking Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers the content horizontally
                  children: [
                    // Left Divider (optional, can be adjusted based on design)
                    Container(
                      width: 30.w,
                      height: 1.h,
                      color: Color(0xFF98A2B3),
                    ),
                    SizedBox(width: 10.w), // Spacing between divider and text
                    // Booking Amount Container
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.h), // Added vertical padding for better appearance
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF98A2B3),
                        ),
                        borderRadius: BorderRadius.circular(8.r), // Optional: Adds rounded corners
                      ),
                      child: CustomText(
                        text: 'Booking Amount',
                        fontSize: 14.sp,
                        color: Color(0xFF98A2B3),
                      ),
                    ),
                    SizedBox(width: 10.w), // Spacing after the text
                    // Right Divider (optional, mirroring the left)
                    Container(
                      width: 30.w,
                      height: 1.h,
                      color: Color(0xFF98A2B3),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                CustomText(
                  text: "\$220.0",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),

                SizedBox(height: 24.h),

                // Start Ride Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: Color(0xFF3A86FF),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        rideState = RideState.started;
                      });
                      _startRideTimer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Ride Time',
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18.r),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

              ],
            ),
          ),
        ));
  }

  void _showFinishTripDialog() {
    String totalTime = _formatTime(_elapsedTime);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(
          text: 'Trip Finished!',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: 'Total time taken: $totalTime',
              fontSize: 16.sp,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: 'Please rate your trip or proceed to exit.',
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _rideTimer?.cancel();
              setState(() => rideState = RideState.rating);
              _showRatingDialog();
            },
            child: CustomText(text: 'Rate Now', fontSize: 16.sp, color: AppColors.blueToggle),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _rideTimer?.cancel();
              setState(() => rideState = RideState.finished);
              Get.back();
            },
            child: CustomText(text: 'Exit', fontSize: 16.sp, color: AppColors.blueToggle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    String eta = '';
    switch (rideState) {
      case RideState.arriving:
        title = 'Arriving';
        eta = '5 minutes';
        break;
      case RideState.coming:
        title = 'Driver is Coming';
        eta = '25 minutes';
        break;
      case RideState.started:
        title = 'Ride Time';
        eta = _formatTime(_elapsedTime);
        break;
      case RideState.rating:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case RideState.finished:
        return Scaffold(body: Center(child: CustomText(text: 'Trip Finished!')));
    }

    return Scaffold(
      appBar: HomeCustomAppBar(title: title, backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: pickupLatLng, zoom: 14),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 50,
                    child: Divider(thickness: 4, indent: 3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Arriving',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: '5 Minute',
                        fontSize: 14.sp,
                        color: Color(0xFF475467),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/44.jpg'),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: widget.rideData['driver'] ?? 'Arlene McCoy',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    CustomText(
                                      text: '(4.8)',
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: widget.rideData['car'] ?? 'Ford Consul Cortina',
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                                CustomText(
                                  text: '${widget.rideData['distance'] ?? '200m'}',
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Total Trip-',
                        fontSize: 14.sp,
                        color: Color(0xFF1D2939),
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: '216',
                        fontSize: 14.sp,
                        color: Color(0xFF1D2939),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (rideState == RideState.arriving || rideState == RideState.coming)

                        ResultItem(
                          imagePath: AppImages.cancellIcon, // Corrected typo to cancelIcon
                          color: Color(0xffF2F4F7),
                          onTap: _showCancelDialog,
                        ),
                      if (rideState == RideState.arriving || rideState == RideState.coming)

                        ResultItem(
                          imagePath: AppImages.chatIcon,
                          color: Color(0xff3A86FF),
                          onTap: () => print('Chat'),
                        ),
                      if (rideState == RideState.arriving || rideState == RideState.coming)

                        ResultItem(
                          imagePath: AppImages.callIcon,
                          color: Color(0xff3A86FF),
                          onTap: () => print('Call'),
                        ),
                      if (rideState == RideState.arriving || rideState == RideState.coming)
                        ResultItem(
                          imagePath: AppImages.shareIcon, // Changed to playIcon
                          color: Color(0xff3A86FF),
                          onTap: _showStartRideDialog,
                        ),
                      if (rideState == RideState.started)
                        SizedBox(
                          width: 328.w,
                          child: CustomButtonWidget(
                            iconWant: false,
                            btnText: 'Finish Trip',
                            onTap: _showRatingDialog,
                            btnColor: AppColors.mainColor,
                            btnTextColor: Colors.white,
                            btnTextSize: 16.sp,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rideTimer?.cancel();
    _mapController.dispose();
    super.dispose();
  }
}