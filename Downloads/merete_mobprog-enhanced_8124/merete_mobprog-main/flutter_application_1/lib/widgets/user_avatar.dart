import 'package:material_ui/material_ui.dart';
import 'package:flutter_application_1/constant.dart';

/// Lab Activity 1: circular profile picture for a user.
///
/// If [imagePath] is given, the image is cropped into a circle.
/// Otherwise the user's initials are shown on a colored background. The
/// color comes from the app palette and is picked from the name, so the
/// same person always gets the same color.
class UserAvatar extends StatelessWidget {
  final String name;
  final String? imagePath;
  final double radius;
  final Color? backgroundColor;

  const UserAvatar({
    super.key,
    required this.name,
    this.imagePath,
    this.radius = 20,
    this.backgroundColor,
  });

  static const List<Color> _palette = [
    fbPrimary,
    fbSecondary,
    fbDarkPrimary,
    Color(0xFF2EB67D),
    Color(0xFF3B82F6),
    Color(0xFFE0A100),
  ];

  Color get _colorFromName =>
      _palette[name.codeUnits.fold<int>(0, (a, b) => a + b) % _palette.length];

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
      backgroundColor: backgroundColor ?? _colorFromName,
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
