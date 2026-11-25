import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';

/// Enhancement 1: the image placeholder from the sample output, a box with
/// an "X" drawn corner to corner. It's shown for posts that have
/// `hasPlaceholder: true` but no real image yet.
class PostPlaceholder extends StatelessWidget {
  const PostPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(220),
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
        color: fbBackground,
        border: Border.all(color: fbLightPrimary, width: 1.5),
      ),
      child: CustomPaint(
        painter: _CrossPainter(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.image_outlined,
              color: fbLightPrimary,
              size: ScreenUtil().setSp(28),
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws the two diagonal lines of the placeholder box.
class _CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fbLightPrimary
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
