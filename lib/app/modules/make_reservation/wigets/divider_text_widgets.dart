import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/home_text_field.dart';
import '../../../uitilies/app_colors.dart';
class DividerTextWidgets extends StatefulWidget {
  final String text;
  final bool showEditIcon;
  final bool pickIpIon;
  final String? editAssetPath;
  final VoidCallback? picUpTap;
  final VoidCallback? mapTap;
  final VoidCallback? editTap;
  final List<Widget>? fields;
  final List<Widget>? initialFields;

  /// New: address to show in map mode
  final String? mapAddress;

  const DividerTextWidgets({
    super.key,
    required this.text,
    this.showEditIcon = false,
    this.editAssetPath,
    this.picUpTap,
    this.mapTap,
    this.editTap,
    this.pickIpIon = false,
    this.fields = const [],
    this.mapAddress,
    this.initialFields  = const [],
  });

  @override
  _DividerTextWidgetsState createState() => _DividerTextWidgetsState();
}

class _DividerTextWidgetsState extends State<DividerTextWidgets> {
  bool _showMapOnly = true; // Initially only map address

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomText(
                  text: widget.text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.privacyTextColor,
                ),
                if (widget.pickIpIon) ...[
                  GestureDetector(
                    onTap: () {
                      if (widget.mapTap != null) widget.mapTap!();
                      setState(() {
                        _showMapOnly = true; // show only map address
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Image.asset(
                        AppImages.map,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      if (widget.picUpTap != null) widget.picUpTap!();
                      setState(() {
                        _showMapOnly = false; // show pickup fields
                      });
                    },
                    child: Image.asset(
                      AppImages.plane,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ],
              ],
            ),
            if (widget.showEditIcon)
              GestureDetector(
                onTap: widget.editTap,
                child: Image.asset(
                  widget.editAssetPath ?? AppImages.editeS,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
          ],
        ),
        const Divider(),

        /// Show map address if in map mode
        if (_showMapOnly && widget.initialFields != null)
          ...widget.initialFields!,

        /// Show pickup fields if in pickup mode
        if (!_showMapOnly && widget.fields!.isNotEmpty)
          Column(
            children: [
              SizedBox(height: 10.h),
              ...widget.fields!,
            ],
          ),
      ],
    );
  }
}


