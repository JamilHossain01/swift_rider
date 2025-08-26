import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLogTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool showObscure;
  final TextEditingController? controller;
  final String? prefixIcon; // Single prefix image asset
  final VoidCallback? onClear;
  final bool showClearButton;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? fillColor;

  const CustomLogTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.showObscure = false,
    this.controller,
    this.prefixIcon,
    this.onClear,
    this.showClearButton = false,
    this.keyboardType = TextInputType.emailAddress,
    this.validator,
    this.focusNode,
    this.borderColor = const Color(0xFFEAECF0),
    this.fillColor = Colors.white,
  }) : super(key: key);

  @override
  _CustomLogTextFieldState createState() => _CustomLogTextFieldState();
}

class _CustomLogTextFieldState extends State<CustomLogTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: _controller,
        obscureText: widget.showObscure,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
            padding: EdgeInsets.only(left: 12.w, right: 5.w),
            child: Image.asset(
              widget.prefixIcon!,
              width: 24.sp,
              height: 24.sp,
              color: Color(0xFF3A74F0),
            ),
          )
              : null,
          suffixIcon: widget.showClearButton && _controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Color(0xFF3A74F0)),
            onPressed: widget.onClear ?? () => _controller.clear(),
          )
              : null,
          filled: true,
          fillColor: widget.fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(color: widget.borderColor!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(color: Color(0xFF3A86FF), width: 2.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
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

