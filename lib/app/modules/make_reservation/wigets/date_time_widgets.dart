import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateandTimeWidgets extends StatelessWidget {
  final String title;
  final String assetPath;
  final ValueNotifier<DateTime?> selectedDate; // Add a notifier for selected date
  final ValueNotifier<TimeOfDay?> selectedTime; // Add a notifier for selected time

  const DateandTimeWidgets({
    super.key,
    required this.title,
    required this.assetPath,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event: open date/time pickers
        if (title.contains('Date')) {
          _selectDate(context); // Open Date Picker
        } else {
          _selectTime(context); // Open Time Picker
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.reservationDropBorderTextColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              Row(
                children: [
                  CustomText(
                    text: _getSelectedValue(), // Display selected date/time
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 8),
                  Image.asset(
                    assetPath,
                    width: 24.w,
                    height: 24.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Open the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked; // Update the selected date
    }
  }

  // Open the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked; // Update the selected time
    }
  }

  // Get the selected value to display in the UI
  String _getSelectedValue() {
    if (title.contains('Date')) {
      if (selectedDate.value != null) {
        return DateFormat('yyyy-MM-dd').format(selectedDate.value!);
      } else {
        return 'Select Date';
      }
    } else {
      if (selectedTime.value != null) {
        return selectedTime.value!.format(Get.context!);
      } else {
        return 'Select Time';
      }
    }
  }
}
