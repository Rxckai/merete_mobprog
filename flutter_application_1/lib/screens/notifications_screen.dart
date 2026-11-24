import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: 'No notifications yet',
        fontSize: ScreenUtil().setSp(14),
        color: Colors.grey,
      ),
    );
  }
}
