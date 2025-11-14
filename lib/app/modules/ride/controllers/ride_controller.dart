import 'package:get/get.dart';

class RideController extends GetxController {
  final RxList<Map<String, dynamic>> rides = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Example: Populate with dummy data
    rides.assignAll([
      {
        'title': 'Office Trip',
        'address': 'Downtown Office',
        'date': 'Tuesday, 09/09/2025',
        'driver': 'John Doe',
        'isConfirmed': true,
        'time': '15 min',
        'distance': '5.0 km',
        'lat': 37.42796133580664,
        'lng': -122.085749655962,
        'dropoffLat': 37.43296265331129,
        'dropoffLng': -122.08832357078792,
        'dropoffAddress': 'Office Park',
        'car': 'Toyota Camry',
        'cost': '\$150.0',
        'eta': '10 minutes',
      },
      // Add more rides as needed
    ]);
  }
}