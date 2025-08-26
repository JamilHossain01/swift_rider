import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPhoneTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;

  /// Prefix can be icon or asset
  final IconData? prefixIcon;
  final String? prefixAsset;

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomPhoneTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.prefixAsset,
    this.controller,
    this.keyboardType = TextInputType.phone,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  _CustomPhoneTextFieldState createState() => _CustomPhoneTextFieldState();
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  late TextEditingController _controller;
  String _selectedCountryCode = '+880'; // Default country code

  // List of country codes for the dropdown
  final List<String> _countryCodes = ['+880', '+1', '+91', '+44'];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = '$_selectedCountryCode 156780****'; // Set default text
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget? _buildIconOrAsset() {
    if (widget.prefixAsset != null) {
      return Image.asset(
        widget.prefixAsset!,
        width: 24.sp,
        height: 24.sp,
      );
    } else if (widget.prefixIcon != null) {
      return Icon(widget.prefixIcon, color: const Color(0xFF3A74F0), size: 24.sp);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_buildIconOrAsset() != null)
                Padding(
                  padding: EdgeInsets.only(left: 8.w), // Add left space
                  child: _buildIconOrAsset()!,
                ),
              SizedBox(width: 8.w), // Space between icon and dropdown
              DropdownButton<String>(
                value: _selectedCountryCode,
                icon: Icon(Icons.arrow_drop_down, color: const Color(0xFFD0D5DD), size: 24.sp),
                iconSize: 24.sp,
                elevation: 16,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountryCode = newValue!;
                    _controller.text = '$newValue 156780****';
                  });
                },
                items: _countryCodes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 8.w),
            ],
          ),
          hintStyle: GoogleFonts.outfit(
            fontSize: 14.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: const BorderSide(color: Color(0xFFEAECF0), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: const BorderSide(color: Color(0xFF3A86FF), width: 2.0),
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
