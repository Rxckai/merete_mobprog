import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/data/dummy_data.dart';
import 'package:flutter_application_1/utils/formatters.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/newsfeed_card.dart';
import 'package:flutter_application_1/widgets/user_avatar.dart';

/// Enhancement 3: new Profile tab. It has a cover, avatar, stats, and only
/// the current user's posts (filtered from the same posts list).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myPosts = posts.where((p) => p.userName == kCurrentUser).toList();
    final totalLikes = myPosts.fold<int>(0, (sum, p) => sum + p.numOfLikes);
    final coverHeight = ScreenUtil().setHeight(140);
    final avatarRadius = ScreenUtil().setSp(48);

    return ListView(
      children: [
        // ---------- Cover + avatar ----------
        SizedBox(
          height: coverHeight + avatarRadius,
          child: Stack(
            children: [
              Container(
                height: coverHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [fbDarkPrimary, fbPrimary, fbSecondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil().setWidth(16),
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: UserAvatar(
                    name: kCurrentUser,
                    radius: avatarRadius,
                    backgroundColor: fbPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ---------- Name + bio ----------
        Padding(
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(16),
            ScreenUtil().setHeight(8),
            ScreenUtil().setWidth(16),
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: kCurrentUser,
                fontSize: ScreenUtil().setSp(22),
                fontWeight: FontWeight.bold,
                color: fbTextDark,
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              CustomText(
                text: 'Building $kAppName one widget at a time.',
                fontSize: ScreenUtil().setSp(13),
                color: fbTextGrey,
              ),
              SizedBox(height: ScreenUtil().setHeight(14)),

              // ---------- Stats ----------
              Row(
                children: [
                  _stat('${myPosts.length}', 'Posts'),
                  _stat('133', 'Friends'),
                  _stat(formatCount(totalLikes), 'Likes'),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              const Divider(),
              CustomText(
                text: 'Posts',
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.bold,
                color: fbTextDark,
              ),
            ],
          ),
        ),

        // ---------- My posts ----------
        ...myPosts.map((p) => NewsfeedCard(key: ValueKey('profile-${p.id}'), post: p)),
      ],
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          CustomText(
            text: value,
            fontSize: ScreenUtil().setSp(17),
            fontWeight: FontWeight.bold,
            color: fbPrimary,
          ),
          CustomText(
            text: label,
            fontSize: ScreenUtil().setSp(12),
            color: fbTextGrey,
          ),
        ],
      ),
    );
  }
}
