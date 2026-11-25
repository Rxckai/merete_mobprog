import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/data/dummy_data.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/user_avatar.dart';

/// Enhancement 3: new Friends tab. It has friend requests (Confirm / Delete)
/// and "People you may know" (Add friend / Remove).
class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  // name -> status text shown after the user taps a button
  final Map<String, String> _status = {};
  final Set<String> _hidden = {};

  void _setStatus(String name, String status) =>
      setState(() => _status[name] = status);

  @override
  Widget build(BuildContext context) {
    final requests = friendRequests.where((n) => !_hidden.contains(n)).toList();
    final suggestions =
        friendSuggestions.where((n) => !_hidden.contains(n)).toList();

    return ListView(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
      children: [
        _header('Friend requests', requests.length),
        ...requests.map(
          (name) => _personTile(
            name: name,
            primaryLabel: 'Confirm',
            secondaryLabel: 'Delete',
            onPrimary: () => _setStatus(name, 'Request accepted'),
            onSecondary: () => setState(() => _hidden.add(name)),
          ),
        ),
        _header('People you may know', null),
        ...suggestions.map(
          (name) => _personTile(
            name: name,
            primaryLabel: 'Add friend',
            secondaryLabel: 'Remove',
            onPrimary: () => _setStatus(name, 'Request sent'),
            onSecondary: () => setState(() => _hidden.add(name)),
          ),
        ),
      ],
    );
  }

  Widget _header(String title, int? count) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(12),
        ScreenUtil().setHeight(14),
        ScreenUtil().setWidth(12),
        ScreenUtil().setHeight(6),
      ),
      child: Row(
        children: [
          CustomText(
            text: title,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.bold,
            color: fbTextDark,
          ),
          if (count != null) ...[
            SizedBox(width: ScreenUtil().setWidth(6)),
            CustomText(
              text: '$count',
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.bold,
              color: fbSecondary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _personTile({
    required String name,
    required String primaryLabel,
    required String secondaryLabel,
    required VoidCallback onPrimary,
    required VoidCallback onSecondary,
  }) {
    final status = _status[name];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(12),
        vertical: ScreenUtil().setHeight(6),
      ),
      child: Row(
        children: [
          UserAvatar(name: name, radius: ScreenUtil().setSp(30)),
          SizedBox(width: ScreenUtil().setWidth(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.bold,
                  color: fbTextDark,
                ),
                SizedBox(height: ScreenUtil().setHeight(6)),
                if (status != null)
                  CustomText(
                    text: status,
                    fontSize: ScreenUtil().setSp(12),
                    color: fbTextGrey,
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: onPrimary,
                          style: FilledButton.styleFrom(
                            backgroundColor: fbPrimary,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(primaryLabel),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(8)),
                      Expanded(
                        child: FilledButton(
                          onPressed: onSecondary,
                          style: FilledButton.styleFrom(
                            backgroundColor: fbUnreadTint,
                            foregroundColor: fbTextDark,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(secondaryLabel),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
