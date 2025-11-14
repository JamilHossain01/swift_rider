import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../wigest/ride_request_buton_wigets.dart';

enum RideState { idle, accepted, started, finished }

class MapScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;
  final double? lat;
  final double? lng;
  final Map<String, dynamic>? rideData;

  const MapScreen({
    super.key,
    this.initialLat,
    this.initialLng,
    this.rideData,
    this.lat,
    this.lng,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _initialPosition =
  const CameraPosition(target: LatLng(23.8041, 90.4152), zoom: 15);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];

  Position? _currentPosition;
  late GoogleMapController _mapController;

  bool isOnline = false;
  int notificationCount = 1;

  RideState rideState = RideState.idle;
  bool showDriverAndUser = false;
  late BitmapDescriptor driverIcon;
  late BitmapDescriptor userIcon;

  final LatLng pickupLatLng = const LatLng(23.8041, 90.4152);
  final LatLng dropLatLng = const LatLng(23.8103, 90.4125);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadCustomIcons();
    _setupMarkers();

    if (widget.initialLat != null && widget.initialLng != null) {
      _initialPosition = CameraPosition(
        target: LatLng(widget.initialLat!, widget.initialLng!),
        zoom: 15,
      );
    }

    if (widget.rideData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showHistoryBottomSheetModal(context, widget.rideData!);
      });
    }
  }

  Future<void> _loadCustomIcons() async {
    driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/icons/car.png",
    );
    userIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/icons/user.png",
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
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
    if (widget.initialLat != null && widget.initialLng != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
            LatLng(widget.initialLat!, widget.initialLng!), 15),
      );
    }
  }

  void _setupMarkers() {
    _markers.add(Marker(
      markerId: const MarkerId("pickup"),
      position: pickupLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    _markers.add(Marker(
      markerId: const MarkerId("dropoff"),
      position: dropLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ));
  }

  void _getPolyline() {
    polylineCoordinates = [
      pickupLatLng,
      const LatLng(23.8060, 90.4160),
      const LatLng(23.8080, 90.4140),
      dropLatLng,
    ];
    setState(() {
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        width: 4,
        color: Colors.black,
        points: polylineCoordinates,
      ));
    });
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    markers.addAll(_markers);

    if (showDriverAndUser) {
      markers.add(
        Marker(
          markerId: const MarkerId("driver"),
          position: pickupLatLng,
          icon: driverIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: const MarkerId("user"),
          position: dropLatLng,
          icon: userIcon,
        ),
      );
    }

    return markers;
  }

  // Show Finish Trip Dialog
  void _showFinishTripDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Icon (top right)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    setState(() {
                      rideState = RideState.idle; // Reset ride state
                    });
                  },
                ),
              ),
              // Checkmark Icon
              Container(
                padding: const EdgeInsets.all(16.0),
             
                child: Image.asset(AppImages.succes,width: 80.w,height: 76.h,)
              ),
              const SizedBox(height: 16.0),
              // Title
              CustomText(
                text: 'Trip Finished',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                top: 0,
                bottom: 8.0,
              ),
              // Message
              CustomText(
                text: 'You have successfully completed the trip for ${widget.rideData?['driver'] ?? 'User'}',
                textAlign: TextAlign.center,
                fontSize: 16.0,
                color: Colors.grey,
                top: 0,
                bottom: 16.0,
              ),
              // Payment Amount
              CustomText(
                text: widget.rideData?['cost'] ?? '\$0.0',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                top: 0,
                bottom: 24.0,
              ),
              // Got it Button
              CustomButtonWidget(
                iconWant: false,
                btnText: 'Got it',
                onTap: () {
                  Navigator.pop(context); // Close dialog
                  setState(() {
                    rideState = RideState.idle; // Reset ride state
                  });
                },
                btnColor: Colors.blue,
                btnTextColor: Colors.white,
                btnTextSize: 16.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            markers: _buildMarkers(),
            polylines: _polylines,
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/women/44.jpg"),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            CustomText(
                              text: "Online",
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            Switch(
                              value: isOnline,
                              onChanged: (val) {
                                setState(() {
                                  isOnline = val;
                                  if (isOnline) {
                                    showDriverAndUser = true;
                                    Timer(const Duration(seconds: 2), () {
                                      _getPolyline();
                                      setState(() {
                                        rideState = RideState.accepted;
                                      });
                                    });
                                  } else {
                                    showDriverAndUser = false;
                                    _polylines.clear();
                                    rideState = RideState.idle;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, size: 28),
                        onPressed: () => setState(() => notificationCount = 0),
                      ),
                      if (notificationCount > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: CustomText(
                              text: "$notificationCount",
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (rideState == RideState.accepted)
            _rideAction("Arrived", () {
              setState(() => rideState = RideState.started);
            }, true),
          if (rideState == RideState.started)
            _rideAction("Finish Trip", () {
              setState(() => rideState = RideState.finished);
              _showFinishTripDialog(); // Show dialog when trip is finished
            }, false),
          if (rideState == RideState.finished)
            const SizedBox.shrink(), // Placeholder to avoid UI overlap
        ],
      ),
    );
  }

  void _showHistoryBottomSheetModal(
      BuildContext context, Map<String, dynamic> rideRequest) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: const NetworkImage(
                              "https://randomuser.me/api/portraits/women/44.jpg"),
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: rideRequest['driver'] ?? 'No Driver',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: rideRequest['address'] ?? '',
                              fontSize: 12,
                              color: AppColors.grayToggle,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: rideRequest['time'] ?? '',
                              fontSize: 12,
                              color: AppColors.grayToggle,
                            ),
                            CustomText(
                              text: rideRequest['distance'] ?? '',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      text: "Date: ${rideRequest['date'] ?? ''}",
                      fontSize: 14,
                    ),
                    CustomText(
                      text: "Driver: ${rideRequest['driver'] ?? 'Pending'}",
                      fontSize: 14,
                    ),
                    CustomText(
                      text: "Distance: ${rideRequest['distance'] ?? ''}",
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _rideAction(String buttonText, VoidCallback onTap, bool dual) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => RideRequestBottomSheet(onAccept: () {}));
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/women/44.jpg"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.rideData?['driver'] ?? 'Driver',
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "User",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      CustomText(
                        text: widget.rideData?['distance'] ?? '',
                      ),
                      CustomText(
                        text: widget.rideData?['cost'] ?? '',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (dual) ...[
              CustomButtonWidget(
                iconWant: false,
                btnText: "Arrived",
                onTap: () {
                  ScaffoldMessenger.of(Get.context!)
                      .showSnackBar(SnackBar(content: CustomText(text: "Driver marked Arrived")));
                },
                btnColor: Colors.blue,
                btnTextColor: Colors.white,
                btnTextSize: 16.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(height: 10),
              CustomButtonWidget(
                iconWant: false,
                btnText: "Tap To Start Trip",
                onTap: onTap,
                btnColor: Colors.transparent,
                borderColor: Colors.blue,
                btnTextColor: Colors.blue,
                btnTextSize: 16.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ] else
              CustomButtonWidget(
                btnText: buttonText,
                onTap: onTap,
                btnColor: Colors.blue,
                btnTextColor: Colors.white,
                btnTextSize: 16.0,
                borderRadius: BorderRadius.circular(8.0), iconWant: false,
              ),
          ],
        ),
      ),
    );
  }
}