import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/data/dummy_data.dart';
import 'package:flutter_application_1/models/app_notification.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/notification_widget.dart';

/// Shows the 20 notifications, split into "New" (today) and "Earlier".
///
/// Which ones are read is kept by HomeScreen ([readIds]) so the unread
/// badge on the bottom navigation bar stays in sync.
class NotificationsScreen extends StatelessWidget {
  final Set<String> readIds;
  final ValueChanged<String> onRead;

  const NotificationsScreen({
    super.key,
    required this.readIds,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No notifications yet',
          fontSize: ScreenUtil().setSp(14),
          color: fbTextGrey,
        ),
      );
    }

    final newest = notifications.first.date;
    bool isNew(DateTime d) => newest.difference(d).inHours < 24;

    final newItems = notifications.where((n) => isNew(n.date)).toList();
    final earlierItems = notifications.where((n) => !isNew(n.date)).toList();

    return ListView(
      children: [
        if (newItems.isNotEmpty) _sectionHeader('New'),
        ...newItems.map(_buildRow),
        if (earlierItems.isNotEmpty) _sectionHeader('Earlier'),
        ...earlierItems.map(_buildRow),
        SizedBox(height: ScreenUtil().setHeight(12)),
      ],
    );
  }

  Widget _buildRow(AppNotification n) => NotificationWidget(
        notification: n,
        isRead: readIds.contains(n.id),
        onTap: () => onRead(n.id),
      );

  Widget _sectionHeader(String title) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(12),
        ScreenUtil().setHeight(12),
        ScreenUtil().setWidth(12),
        ScreenUtil().setHeight(6),
      ),
      child: CustomText(
        text: title,
        fontSize: ScreenUtil().setSp(16),
        fontWeight: FontWeight.bold,
        color: fbTextDark,
      ),
    );
  }
}
