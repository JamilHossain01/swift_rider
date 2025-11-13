import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final Rx<BitmapDescriptor?> startIcon = Rx<BitmapDescriptor?>(null);
  final Rx<BitmapDescriptor?> endIcon = Rx<BitmapDescriptor?>(null);
  final RxBool isLoadingIcons = true.obs;
  final RxList<Marker> markers = <Marker>[].obs;
  final RxList<Polyline> polylines = <Polyline>[].obs;
  late LatLng pickupLatLng;
  late LatLng dropLatLng;

  @override
  void onInit() {
    super.onInit();
    pickupLatLng = const LatLng(23.8041, 90.4152); // Dhaka
    dropLatLng = const LatLng(23.8103, 90.4125);
    _loadCustomMarkers();
    _setupMarkers();
    _getDummyPolyline();
  }

  Future<void> _loadCustomMarkers() async {
    try {
      startIcon.value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/start_icon.png',
      );
      endIcon.value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/end_icon.png',
      );
      isLoadingIcons.value = false;
    } catch (e) {
      print("Error loading custom markers: $e");
      isLoadingIcons.value = false; // Fallback to default behavior
    }
  }

  void _setupMarkers() {
    if (startIcon.value != null && endIcon.value != null) {
      markers.assignAll([
        Marker(
          markerId: const MarkerId("pickup"),
          position: pickupLatLng,
          icon: startIcon.value!,
        ),
        Marker(
          markerId: const MarkerId("dropoff"),
          position: dropLatLng,
          icon: endIcon.value!,
        ),
      ]);
    } else {
      // Fallback to default icons
      markers.assignAll([
        Marker(
          markerId: const MarkerId("pickup"),
          position: pickupLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
        Marker(
          markerId: const MarkerId("dropoff"),
          position: dropLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ),
      ]);
    }
  }

  void _getDummyPolyline() {
    polylines.assignAll([
      Polyline(
        polylineId: const PolylineId("dummyRoute"),
        width: 4,
        color: Colors.black,
        points: [pickupLatLng, dropLatLng],
      ),
    ]);
  }
}