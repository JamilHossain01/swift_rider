import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../controllers/luggage_conrtoller.dart';





// Luggage Class
class FirstXType {
  final String label;
  int count;

  FirstXType({required this.label, this.count = 0});
}

class LuggageWidget extends StatelessWidget {
  // GetX Controller instance
  final LuggageController luggageController = Get.put(LuggageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              // Toggle the expansion state when clicked
              luggageController.isExpanded.value = !luggageController.isExpanded.value;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Luggage',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueToggle, // You can use a custom color like AppColors.privacyTextColor
                ),
                Row(
                  children: [
                    // Display total luggage count dynamically
                    CustomText(
                      text: luggageController.totalLuggage.toString(),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // You can customize this color
                    ),
                    Icon(
                      luggageController.isExpanded.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Show luggage types when expanded
          if (luggageController.isExpanded.value)
            Column(
              children: luggageController.luggageTypes.map((luggageType) {
                return luggageCategory(luggageType);
              }).toList(),
            ),
        ],
      );
    });
  }

  // Widget for each luggage category
  Widget luggageCategory(FirstXType luggageType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: luggageType.label,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black, // You can use a custom color
        ),
        Row(
          children: [
            // Decrement button
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => luggageController.decrement(luggageType),
            ),
            // Display the count of the luggage type
            CustomText(
              text: '${luggageType.count}',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black, // You can customize this color
            ),
            // Increment button
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => luggageController.increment(luggageType),
            ),
          ],
        ),
      ],
    );
  }
}
