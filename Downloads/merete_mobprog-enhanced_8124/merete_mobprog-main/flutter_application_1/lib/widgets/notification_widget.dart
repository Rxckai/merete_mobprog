import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/app_notification.dart';
import 'package:flutter_application_1/utils/formatters.dart';
import 'package:flutter_application_1/widgets/user_avatar.dart';

/// One notification row: avatar with a type badge, "Name + action",
/// the post or description it refers to, and how long ago it happened.
/// Unread rows get a lavender background and a dot on the right.
class NotificationWidget extends StatelessWidget {
  final AppNotification notification;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationWidget({
    super.key,
    required this.notification,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final type = notification.type;
    final isSystem = type == NotificationType.memory;

    return Material(
      color: isRead ? Colors.white : fbUnreadTint,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(12),
            vertical: ScreenUtil().setHeight(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Avatar + type badge ----------
              Stack(
                clipBehavior: Clip.none,
                children: [
                  UserAvatar(
                    name: notification.userName,
                    imagePath: notification.avatarPath,
                    radius: ScreenUtil().setSp(26),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: type.color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        type.icon,
                        color: Colors.white,
                        size: ScreenUtil().setSp(11),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: ScreenUtil().setWidth(12)),

              // ---------- Text ----------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(13),
                          color: fbTextDark,
                        ),
                        children: isSystem
                            ? [TextSpan(text: type.message)]
                            : [
                                TextSpan(
                                  text: notification.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: ' ${type.message}'),
                              ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(3)),
                    Text(
                      notification.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: fbTextGrey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(4)),
                    Text(
                      formatNotificationTime(notification.date),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(11),
                        color: isRead ? fbTextGrey : fbPrimary,
                        fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- More + unread dot ----------
              Column(
                children: [
                  const Icon(Icons.more_horiz, color: fbTextGrey),
                  if (!isRead)
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: fbPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
