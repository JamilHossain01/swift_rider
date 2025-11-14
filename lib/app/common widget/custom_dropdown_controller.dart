import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom text/custom_text_widget.dart';


class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final Color fillColor;  // For the fill color of the dropdown
  final Color borderColor;  // For the border color of the dropdown

  const CustomDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.fillColor = Colors.white,  // Default fill color
    this.borderColor = Colors.grey, // Default border color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14.h, color: Colors.grey), // Add hint styling
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            fillColor: fillColor,  // Fill color
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),  // Border color for default
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),  // Ensure same border color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),  // Same border color when focused
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: CustomText(
                text: item,
                color: Colors.black,
                fontSize: 15.h,
                overflow: TextOverflow.ellipsis,  // Prevent text from overflowing
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
