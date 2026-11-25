/// One newsfeed post.
///
/// Enhancement 1: every post carries its own values instead of hardcoding
/// them inside the card:
///  - number values: [numOfLikes], [numOfComments], [numOfShares]
///  - a date: [date] (a real DateTime, formatted when it's displayed)
///  - its image state: a real image ([imagePath]), an image placeholder
///    ([hasPlaceholder]), or neither (text-only post)
class Post {
  final String id;
  final String userName;
  final String? avatarPath;
  final String content;
  final String? hashtag;
  final DateTime date;
  final String? imagePath;
  final bool hasPlaceholder;
  final int numOfLikes;
  final int numOfComments;
  final int numOfShares;

  const Post({
    required this.id,
    required this.userName,
    required this.content,
    required this.date,
    this.avatarPath,
    this.hashtag,
    this.imagePath,
    this.hasPlaceholder = false,
    this.numOfLikes = 0,
    this.numOfComments = 0,
    this.numOfShares = 0,
  });

  /// True when the post shows something in the image area.
  bool get hasMedia => imagePath != null || hasPlaceholder;
}
