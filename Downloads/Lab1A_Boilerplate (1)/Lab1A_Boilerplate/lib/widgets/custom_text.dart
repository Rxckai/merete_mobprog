import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// A small reusable text widget.
// Use it anywhere you need the same text style, instead of writing
// the same TextStyle again and again (DRY).

class CustomText extends StatelessWidget {
  // Creates reusable text with customizable size, weight, and color.
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  // Properties allow each use of CustomText to have a different appearance.
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
