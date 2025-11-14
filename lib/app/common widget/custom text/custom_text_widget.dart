import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.text = "",
    this.overflow = TextOverflow.fade,
    this.letterSpace,
    this.underline = false,
    this.useSFPro = false, // Optional: toggle sf-pro-display
    this.initialValue, // Optional initial value (e.g., points or text)
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final dynamic letterSpace;
  final bool underline;
  final bool useSFPro;
  final dynamic initialValue;

  @override
  Widget build(BuildContext context) {
    final displayText = initialValue != null
        ? (initialValue is num ? initialValue.toString() : initialValue.toString())
        : text;

    try {
      return Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: Text(
          displayText,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.getFont(
            useSFPro ? 'sf-pro-display' : 'poppins',
            letterSpacing: letterSpace,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            decorationColor: Colors.grey,
            decoration: underline ? TextDecoration.underline : TextDecoration.none,
          ).copyWith(
            fontFamilyFallback: ['poppins'], // Fallback to poppins if sf-pro-display fails
          ),
        ),
      );
    } catch (e) {
      print('Font loading error: $e'); // Log the error for debugging
      return Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: Text(
          displayText,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.poppins(
            letterSpacing: letterSpace,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            decorationColor: Colors.grey,
            decoration: underline ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      );
    }
  }
}