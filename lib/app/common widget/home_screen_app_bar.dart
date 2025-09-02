import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

class HomeCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? fontSize;
  final VoidCallback? onTap;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool forceMaterialTransparency;
  final bool showBackButton; // 👈 New flag
  final List<Widget>? actions;

  const HomeCustomAppBar({
    Key? key,
    required this.title,
    this.fontSize,
    this.centerTitle = true,
    this.backgroundColor = Colors.transparent,
    this.forceMaterialTransparency = true,
    this.actions,
    this.showBackButton = true, // default = show
    this.onTap,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false, // we handle leading manually
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: showBackButton
          ? IconButton(
        icon: Image.asset(
          AppImages.leftArrow,
          width: 40.w,
          height: 40.h,
        ),
        onPressed: onTap ??
                () {
              if (Get.isSnackbarOpen) {
                Get.closeCurrentSnackbar();
              }
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                if (kDebugMode) {
                  print("No routes to pop");
                }
              }
            },
      )
          : null, // 👈 hides back button if false
      elevation: forceMaterialTransparency ? 0 : null,
    );
  }
}
