import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

/// Lab Activity 1: one reusable widget for the Like / Comment / Share buttons.
///
/// Expanded makes the three buttons share the row equally, and InkWell
/// gives the ripple effect when tapped.
class PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const PostActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = fbTextGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: ScreenUtil().setSp(18)),
              SizedBox(width: ScreenUtil().setWidth(6)),
              CustomText(
                text: label,
                fontSize: ScreenUtil().setSp(13),
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
