import 'package:material_ui/material_ui.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.fontStyle,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
      ),
    );
  }
}
