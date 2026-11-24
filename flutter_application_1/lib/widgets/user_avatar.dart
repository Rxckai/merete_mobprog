import 'package:material_ui/material_ui.dart';

/// Enhancement 2: circular profile picture for a user.
///
/// If [imagePath] is given, the image is cropped into a circle.
/// Otherwise the user's initials are shown on a colored background.
class UserAvatar extends StatelessWidget {
  final String name;
  final String? imagePath;
  final double radius;
  final Color backgroundColor;

  const UserAvatar({
    super.key,
    required this.name,
    this.imagePath,
    this.radius = 20,
    this.backgroundColor = Colors.blueGrey,
  });

  String get _initials {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: imagePath != null ? AssetImage(imagePath!) : null,
      child: imagePath == null
          ? Text(
              _initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: radius * 0.8,
              ),
            )
          : null,
    );
  }
}
