import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/post_action_button.dart';
import 'package:flutter_application_1/widgets/post_image.dart';
import 'package:flutter_application_1/widgets/user_avatar.dart';

class NewsfeedCard extends StatefulWidget {
  final String userName;
  final String postContent;
  final String? hashtag;
  final String date;
  final String? avatarPath; // profile picture (Enhancement 2)
  final String? imagePath; // post image (Enhancement 1)
  final int numOfLikes;
  final int numOfComments;
  final int numOfShares;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.hashtag,
    this.avatarPath,
    this.imagePath,
    this.numOfLikes = 0,
    this.numOfComments = 0,
    this.numOfShares = 0,
  });

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
    _likes = widget.numOfLikes;
    _comments = widget.numOfComments;
    _shares = widget.numOfShares;
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

  // 100000 -> 100K, 1500 -> 1.5K
  String _formatCount(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    }
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
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
                  name: widget.userName,
                  imagePath: widget.avatarPath,
                  radius: ScreenUtil().setSp(20),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: '${widget.date} · ',
                            fontSize: ScreenUtil().setSp(12),
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.public,
                            color: Colors.grey,
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
              text: widget.postContent,
              fontSize: ScreenUtil().setSp(13),
              color: Colors.black,
            ),
          ),
          if (widget.hashtag != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                padding,
                ScreenUtil().setHeight(6),
                padding,
                0,
              ),
              child: CustomText(
                text: widget.hashtag!,
                fontSize: ScreenUtil().setSp(13),
                color: fbPrimary,
              ),
            ),
          SizedBox(height: ScreenUtil().setHeight(8)),

          // ---------- Enhancement 1: image widget ----------
          if (widget.imagePath != null) PostImage(imagePath: widget.imagePath!),

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
                  text: _formatCount(_likes),
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[700],
                ),
                const Spacer(),
                CustomText(
                  text:
                      '${_formatCount(_comments)} Comments   ${_formatCount(_shares)} Shares',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
          Divider(height: 1, indent: padding, endIndent: padding),

          // ---------- Enhancement 3: widget-based action buttons ----------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Row(
              children: [
                PostActionButton(
                  icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: 'Like',
                  color: _isLiked ? fbPrimary : Colors.black54,
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
                UserAvatar(name: 'Mhark Denver Merete', radius: ScreenUtil().setSp(15)),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(12)),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
              color: Colors.grey[700],
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
