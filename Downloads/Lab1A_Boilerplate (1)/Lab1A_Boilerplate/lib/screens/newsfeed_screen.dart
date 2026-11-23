import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

// The newsfeed: a list of two posts.
// TODO: Post 1 is YOUR post. Replace 'Your Name' with your own name
// and write your own post text.
// TODO: Post 2 is by a CLASSMATE you pick. Replace "Classmate's Name"
// with their name and write their post text.

class Post {
  // Creates a post with the information needed by a NewsFeedCard.
  Post({
    required this.authorName,
    required this.date,
    required this.text,
    required this.likes,
    this.imageAsset,
  });

  // Text and image values displayed for this post.
  final String authorName;
  final String date;
  final String text;
  // The like count can change when the user taps the Like button.
  int likes;
  // An optional asset path; null means that no post image should be shown.
  final String? imageAsset;
}

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  // Stores the posts shown in the newsfeed list.
  final List<Post> _posts = [
    Post(
      authorName: 'Richmond Halili',
      date: 'October 11',
      text: 'LF SISIG PANG PULUTAN',
      likes: 100,
      imageAsset: null,
    ),
    Post(
      authorName: "JONJUAN CRUZ",
      date: 'December 2',
      text: 'WTG????',
      likes: 200,
      // TODO: Add an image file named post_image.png to assets/images/,
      // or change this path to your own image. If the file is missing,
      // the card shows a grey placeholder instead of crashing.
      imageAsset: 'assets/images/aaaa.jpg',
    ),
  ];

  // Increments a post's like count and rebuilds the feed.
  void _likePost(int index) {
    setState(() {
      _posts[index].likes += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ListView.builder creates a scrollable list and builds visible cards.
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return NewsFeedCard(
          authorName: post.authorName,
          date: post.date,
          text: post.text,
          likes: post.likes,
          imageAsset: post.imageAsset,
          onLike: () => _likePost(index),
        );
      },
    );
  }
}
