import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool showObscure;
  final TextEditingController? controller;
  final void Function(String)? onChanged; // Add this line


  // Icons
  final IconData? prefixIcon1; // First prefix icon (Material icon)
  final String? prefixAsset1;  // First prefix icon (Asset image)
  final IconData? prefixIcon2; // Second prefix icon (Material icon)
  final String? prefixAsset2;  // Second prefix icon (Asset image)

  final VoidCallback? onClear;
  final bool showClearButton;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? fillColor;
  final bool showDropdown; // For dropdown suffix

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.showObscure = false,
    this.controller,
    this.prefixIcon1,
    this.prefixAsset1,
    this.prefixIcon2,
    this.prefixAsset2,
    this.onClear,
    this.showClearButton = false,
    this.keyboardType = TextInputType.emailAddress,
    this.validator,
    this.focusNode,
    this.borderColor = const Color(0xFFEAECF0),
    this.fillColor = Colors.white,
    this.showDropdown = false, this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isObscure = widget.showObscure;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget? _buildIconOrAsset({IconData? icon, String? asset}) {
    if (asset != null) {
      return Image.asset(
        asset,
        width: 20.sp,
        height: 20.sp,
      );
    } else if (icon != null) {
      return Icon(icon, color: const Color(0xFF3A74F0), size: 20.sp);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child:
      TextFormField(
        controller: _controller,
        obscureText: _isObscure,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: (widget.prefixIcon1 != null ||
              widget.prefixAsset1 != null ||
              widget.prefixIcon2 != null ||
              widget.prefixAsset2 != null)
              ? Padding(
            padding:
            EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.prefixIcon1 != null ||
                    widget.prefixAsset1 != null)
                  _buildIconOrAsset(
                    icon: widget.prefixIcon1,
                    asset: widget.prefixAsset1,
                  )!,
                if (widget.prefixIcon2 != null ||
                    widget.prefixAsset2 != null)
                  _buildIconOrAsset(
                    icon: widget.prefixIcon2,
                    asset: widget.prefixAsset2,
                  )!,
              ],
            ),
          )
              : null,
          suffixIcon: widget.showDropdown
              ? Icon(Icons.arrow_drop_down,
              color: Colors.grey.shade600, size: 24.sp)
              : widget.showObscure
              ? IconButton(
            icon: Icon(
              _isObscure
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: const Color(0xFFD0D5DD),
              size: 24.sp,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
              : null,
          filled: true,
          fillColor: widget.fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide:
            BorderSide(color: widget.borderColor!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide:
            const BorderSide(color: Color(0xFF3A86FF), width: 2.0),
          ),
          contentPadding:
          EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
        ),
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
