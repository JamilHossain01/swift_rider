import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class OrderDetailsRow extends StatelessWidget {
  final String label;
  final Widget child;

  const OrderDetailsRow({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CustomText(
        //       text: label,
        //       fontSize: 16.sp,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.black.withOpacity(0.6),
        //     ),
        //     child,
        //   ],
        // ),
      ],
    );
  }
}
