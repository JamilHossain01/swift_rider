import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/modules/ride/views/riude_tracin_view.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/ride_controller.dart';
import '../widgets/history_card.dart';





class UserHistoryView extends StatelessWidget {
  const UserHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final RideController rideController = Get.put(RideController());

    return Scaffold(
      appBar: HomeCustomAppBar(title: 'History'),
      body: Obx(() => ListView(
        padding: EdgeInsets.all(12.r),
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => RideTrackingScreen(
                rideData: {
                  'title': 'Upcoming',
                  'driver': 'Arlene McCoy',
                  'car': 'Ford Consul Cortina',
                  'distance': '10.2 km',
                  'cost': '\$220.0',
                  'pickup': {
                    'lat': 37.42796133580664,
                    'lng': -122.085749655962,
                    'address': '639 Elgin St Celina, Delaware 10299'
                  },
                  'dropoff': {
                    'lat': 37.43296265331129,
                    'lng': -122.08832357078792,
                    'address': '8502 Preston Rd. Inglewood, Maine 98380'
                  },
                  'eta': '5 minutes',
                },
              ));
            },
            child: HistoryCard(
              title: "Upcoming",
              address: "Technical Bus Stop",
              date: "Wednesday, 09/10/2025", // Current date
              driver: "Confirmed",
              isConfirmed: true,
              time: "0.0 min",
              distance: "0.0 km",
              lat: 37.42796133580664,
              lng: -122.085749655962,
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {
              Get.to(() => RideTrackingScreen(
                rideData: {
                  'title': 'My University',
                  'driver': 'Jenny Wilson',
                  'car': 'Sedan',
                  'distance': '2.3 km',
                  'cost': '\$256.0',
                  'pickup': {
                    'lat': 37.42796133580664,
                    'lng': -122.085749655962,
                    'address': '639 Elgin St Celina, Delaware 10299'
                  },
                  'dropoff': {
                    'lat': 37.43296265331129,
                    'lng': -122.08832357078792,
                    'address': '8502 Preston Rd. Inglewood, Maine 98380'
                  },
                  'eta': '25 minutes',
                  'isPast': true, // Flag for past ride
                },
              ));
            },
            child: HistoryCard(
              title: "My University",
              address: "Beza Building, Aadis 4586",
              date: "Saturday, 12/12/2024",
              driver: "",
              isConfirmed: false,
              time: "43 min",
              distance: "2.3 km",
              lat: 37.43296265331129,
              lng: -122.08832357078792,
            ),
          ),
          // Dynamic history from controller (assuming 'rides' property)
          ...rideController.rides.map((ride) => Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: GestureDetector(
              onTap: () {
                Get.to(() => RideTrackingScreen(
                  rideData: {
                    'title': ride['title'] ?? 'Untitled',
                    'driver': ride['driver'] ?? '',
                    'car': ride['car'] ?? 'Unknown',
                    'distance': ride['distance'] ?? '0.0 km',
                    'cost': ride['cost'] ?? '\$0.0',
                    'pickup': {
                      'lat': ride['lat'] ?? 0.0,
                      'lng': ride['lng'] ?? 0.0,
                      'address': ride['address'] ?? 'Unknown'
                    },
                    'dropoff': {
                      'lat': ride['dropoffLat'] ?? 0.0,
                      'lng': ride['dropoffLng'] ?? 0.0,
                      'address': ride['dropoffAddress'] ?? 'Unknown'
                    },
                    'eta': ride['eta'] ?? '0 minutes',
                    'isPast': ride['isConfirmed'] == false,
                  },
                ));
              },
              child: HistoryCard(
                title: ride['title'] ?? 'Untitled',
                address: ride['address'] ?? 'Unknown',
                date: ride['date'] ?? 'Unknown',
                driver: ride['driver'] ?? '',
                isConfirmed: ride['isConfirmed'] ?? false,
                time: ride['time'] ?? '0.0 min',
                distance: ride['distance'] ?? '0.0 km',
                lat: ride['lat'] ?? 0.0,
                lng: ride['lng'] ?? 0.0,
              ),
            ),
          )).toList(),
        ],
      )),
    );
  }
}