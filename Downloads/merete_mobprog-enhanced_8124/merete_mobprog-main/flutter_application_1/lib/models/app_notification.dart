import 'package:material_ui/material_ui.dart';

/// The kinds of notifications the app can show. Each one has its own
/// message, badge icon and badge color.
enum NotificationType {
  like('reacted to your post.', Icons.thumb_up, Color(0xFF6C3CE1)),
  comment('commented on your post.', Icons.chat_bubble, Color(0xFF2EB67D)),
  share('shared your post.', Icons.share, Color(0xFF3B82F6)),
  friendRequest('sent you a friend request.', Icons.person_add, Color(0xFFFF7A59)),
  tag('tagged you in a post.', Icons.local_offer, Color(0xFFE0A100)),
  mention('mentioned you in a comment.', Icons.alternate_email, Color(0xFF14B8A6)),
  birthday('has a birthday today. Say happy birthday!', Icons.cake, Color(0xFFEC4899)),
  memory('You have a memory to look back on today.', Icons.history, Color(0xFF3B1F8C));

  final String message;
  final IconData icon;
  final Color color;

  const NotificationType(this.message, this.icon, this.color);
}

/// One notification row (the "Test / Posted: Post / Description" item in
/// the sample output).
class AppNotification {
  final String id;
  final String userName;
  final String? avatarPath;
  final NotificationType type;
  final String description;
  final DateTime date;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.userName,
    required this.type,
    required this.description,
    required this.date,
    this.avatarPath,
    this.isRead = false,
  });
}
