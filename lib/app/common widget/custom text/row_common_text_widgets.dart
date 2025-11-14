import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text_widget.dart';

class RowTexCommonWidgets extends StatelessWidget {
  final String? text1;
  final String? text2;
  const RowTexCommonWidgets({
    super.key, this.text1, this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [     CustomText(
        text: text1 ?? "",
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF5C5C5C),
      ),

        CustomText(
          text: text2 ?? '',
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1C1B1C),
        ),
      ],);
  }
}
