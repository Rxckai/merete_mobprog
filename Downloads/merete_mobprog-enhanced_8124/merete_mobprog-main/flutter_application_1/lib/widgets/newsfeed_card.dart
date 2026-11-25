import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/utils/formatters.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/post_action_button.dart';
import 'package:flutter_application_1/widgets/post_image.dart';
import 'package:flutter_application_1/widgets/post_placeholder.dart';
import 'package:flutter_application_1/widgets/user_avatar.dart';

/// Enhancement 1: a dynamic post. The card has no hardcoded content. It
/// reads everything (name, text, numbers, date, image or placeholder) from
/// the [Post] it's given, so the same widget draws all 10 posts.
class NewsfeedCard extends StatefulWidget {
  final Post post;

  const NewsfeedCard({super.key, required this.post});

  @override
  State<NewsfeedCard> createState() => _NewsfeedCardState();
}

class _NewsfeedCardState extends State<NewsfeedCard> {
  late int _likes;
  late int _comments;
  late int _shares;
  bool _isLiked = false;

  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _likes = widget.post.numOfLikes;
    _comments = widget.post.numOfComments;
    _shares = widget.post.numOfShares;
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  // Like / unlike: the number of likes goes up or down by one.
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
  }

  // Comment button jumps to the "Write a comment..." box.
  void _focusComment() => _commentFocus.requestFocus();

  void _submitComment(String text) {
    if (text.trim().isEmpty) return;
    setState(() => _comments++);
    _commentController.clear();
    _commentFocus.unfocus();
    _showMessage('Comment posted');
  }

  void _share() {
    setState(() => _shares++);
    _showMessage('Post shared');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final padding = ScreenUtil().setWidth(10);

    return Card(
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Header: avatar, name, date ----------
          Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              children: [
                UserAvatar(
                  name: post.userName,
                  imagePath: post.avatarPath,
                  radius: ScreenUtil().setSp(20),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: post.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: fbTextDark,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: '${formatPostDate(post.date)} · ',
                            fontSize: ScreenUtil().setSp(12),
                            color: fbTextGrey,
                          ),
                          Icon(
                            Icons.public,
                            color: fbTextGrey,
                            size: ScreenUtil().setSp(13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
          ),

          // ---------- Post text + hashtag ----------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomText(
              text: post.content,
              fontSize: ScreenUtil().setSp(13),
              color: fbTextDark,
            ),
          ),
          if (post.hashtag != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                padding,
                ScreenUtil().setHeight(6),
                padding,
                0,
              ),
              child: CustomText(
                text: post.hashtag!,
                fontSize: ScreenUtil().setSp(13),
                color: fbPrimary,
              ),
            ),
          SizedBox(height: ScreenUtil().setHeight(8)),

          // ---------- Enhancement 1: image, placeholder, or none ----------
          if (post.imagePath != null)
            PostImage(imagePath: post.imagePath!, heroTag: 'post-${post.id}')
          else if (post.hasPlaceholder)
            const PostPlaceholder(),

          // ---------- Likes / comments / shares count ----------
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: ScreenUtil().setHeight(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: fbPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: ScreenUtil().setSp(10),
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(5)),
                CustomText(
                  text: formatCount(_likes),
                  fontSize: ScreenUtil().setSp(12),
                  color: fbTextGrey,
                ),
                const Spacer(),
                CustomText(
                  text:
                      '${formatCount(_comments)} Comments   ${formatCount(_shares)} Shares',
                  fontSize: ScreenUtil().setSp(12),
                  color: fbTextGrey,
                ),
              ],
            ),
          ),
          Divider(height: 1, indent: padding, endIndent: padding),

          // ---------- Like / Comment / Share buttons ----------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Row(
              children: [
                PostActionButton(
                  icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: 'Like',
                  color: _isLiked ? fbPrimary : fbTextGrey,
                  onTap: _toggleLike,
                ),
                PostActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comment',
                  onTap: _focusComment,
                ),
                PostActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: _share,
                ),
              ],
            ),
          ),
          Divider(height: 1, indent: padding, endIndent: padding),

          // ---------- "Most relevant" ----------
          Padding(
            padding: EdgeInsets.fromLTRB(
              padding,
              ScreenUtil().setHeight(6),
              padding,
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: 'Most relevant',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black87),
              ],
            ),
          ),

          // ---------- Write a comment box ----------
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: ScreenUtil().setHeight(6),
            ),
            child: Row(
              children: [
                UserAvatar(name: kCurrentUser, radius: ScreenUtil().setSp(15)),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(12)),
                    decoration: BoxDecoration(
                      color: fbBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            focusNode: _commentFocus,
                            onSubmitted: _submitComment,
                            textInputAction: TextInputAction.send,
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        _commentIcon(Icons.emoji_emotions_outlined),
                        _commentIcon(Icons.camera_alt_outlined),
                        _commentIcon(Icons.gif_box_outlined),
                        SizedBox(width: ScreenUtil().setWidth(8)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------- View comments ----------
          Padding(
            padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
            child: CustomText(
              text: 'View comments',
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              color: fbTextGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(3),
        vertical: ScreenUtil().setHeight(8),
      ),
      child: Icon(icon, size: ScreenUtil().setSp(16), color: Colors.grey),
    );
  }
}
