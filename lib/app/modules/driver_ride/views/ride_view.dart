import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/ride_controller.dart';
import '../widgets/history_card.dart';

class DriverHistoryView extends StatelessWidget {
  const DriverHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeCustomAppBar(title: 'History'),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children:  [
          GestureDetector(

            child: HistoryCard(
              title: "Upcoming",
              address: "Tecnical bus stop",
              date: "Saturday _ 06/25/2025",
              driver: "Confirmed",
              isConfirmed: true,
              time: "0.0 min",
              distance: "0.0 km",
              lat: 37.42796133580664,
              lng: -122.085749655962,
            ),
          ),
          SizedBox(height: 12),
          HistoryCard(
            title: "My University",
            address: "Beza Building, aadis 4586",
            date: "Saturday _ 12/12/2024",
            driver: "",
            isConfirmed: false,
            time: "43 min",
            distance: "2.3 km",
            lat: 37.43296265331129,
            lng: -122.08832357078792,
          ),
        ],
      ),
    );
  }
}

