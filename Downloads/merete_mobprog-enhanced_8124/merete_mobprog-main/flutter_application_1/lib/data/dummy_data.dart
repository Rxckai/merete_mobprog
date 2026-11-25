import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/app_notification.dart';
import 'package:flutter_application_1/models/post.dart';

const String _doomsday = 'assets/images/doomsday.jpg';
const String _juan = 'assets/images/juan.png';

// ---------------------------------------------------------------------------
// General Enhancement: 10 posts.
// Each one has its own like/comment/share numbers and date, and is either
// an image post, a placeholder post, or a text-only post.
// ---------------------------------------------------------------------------
final List<Post> posts = [
  Post(
    id: 'p1',
    userName: 'Avengers Doomsday',
    avatarPath: _doomsday,
    content: 'I am Doomsday.',
    hashtag: '#VillainsAssemble',
    date: DateTime(2026, 11, 25, 9, 30),
    imagePath: _doomsday, // image
    numOfLikes: 100000,
    numOfComments: 4200,
    numOfShares: 1850,
  ),
  Post(
    id: 'p2',
    userName: 'Juan Dela Cruz',
    avatarPath: _juan,
    content: 'Finally finished my Flutter lab activity! Who else is coding tonight?',
    hashtag: '#MobileProgramming',
    date: DateTime(2026, 11, 24, 22, 15),
    numOfLikes: 58, // text only
    numOfComments: 3,
    numOfShares: 1,
  ),
  Post(
    id: 'p3',
    userName: 'Cyrus Robles',
    content: 'Kamusta, mga tambay? Coffee run later after class?',
    date: DateTime(2026, 11, 23, 16, 40),
    numOfLikes: 100, // text only
    numOfComments: 12,
    numOfShares: 0,
  ),
  Post(
    id: 'p4',
    userName: 'Roben Juanatas',
    content: 'Kicking off the holiday season with ICpEP-NCR!',
    hashtag: '#ICpEPNCR',
    date: DateTime(2026, 11, 21, 18, 0),
    hasPlaceholder: true, // placeholder
    numOfLikes: 342,
    numOfComments: 27,
    numOfShares: 14,
  ),
  Post(
    id: 'p5',
    userName: kCurrentUser,
    content: 'Tambayan v2 is live: more tabs, dynamic posts, and a fresh violet look.',
    hashtag: '#BuiltWithFlutter',
    date: DateTime(2026, 11, 20, 20, 5),
    hasPlaceholder: true, // placeholder
    numOfLikes: 1530,
    numOfComments: 88,
    numOfShares: 23,
  ),
  Post(
    id: 'p6',
    userName: 'Juan Dela Cruz',
    avatarPath: _juan,
    content: 'New profile pic, who dis?',
    date: DateTime(2026, 11, 15, 12, 20),
    imagePath: _juan, // image
    numOfLikes: 764,
    numOfComments: 51,
    numOfShares: 2,
  ),
  Post(
    id: 'p7',
    userName: 'Bea Santos',
    content: 'Reminder: the INF248 capstone defense schedule is out. Good luck, everyone!',
    hashtag: '#INF248MWA',
    date: DateTime(2026, 11, 2, 8, 45),
    numOfLikes: 215, // text only
    numOfComments: 40,
    numOfShares: 31,
  ),
  Post(
    id: 'p8',
    userName: 'Avengers Doomsday',
    avatarPath: _doomsday,
    content: 'December 18. Everything changes.',
    hashtag: '#AvengersDoomsday',
    date: DateTime(2026, 10, 11, 10, 0),
    imagePath: _doomsday, // image
    numOfLikes: 2300000,
    numOfComments: 98000,
    numOfShares: 410000,
  ),
  Post(
    id: 'p9',
    userName: 'Carla Mendoza',
    content: 'Weekend hike done! Views were worth every step.',
    hashtag: '#Rizal',
    date: DateTime(2026, 9, 28, 17, 30),
    hasPlaceholder: true, // placeholder
    numOfLikes: 489,
    numOfComments: 19,
    numOfShares: 6,
  ),
  Post(
    id: 'p10',
    userName: kCurrentUser,
    content: 'First post on Tambayan. Hello, world!',
    date: DateTime(2025, 12, 18, 9, 0),
    numOfLikes: 37, // text only
    numOfComments: 5,
    numOfShares: 0,
  ),
];

// ---------------------------------------------------------------------------
// General Enhancement: 20 notifications (newest first).
// ---------------------------------------------------------------------------
final List<AppNotification> notifications = [
  AppNotification(id: 'n1', userName: 'Cyrus Robles', type: NotificationType.like, description: '"Tambayan v2 is live: more tabs, dynamic posts..."', date: DateTime(2026, 11, 25, 12, 10)),
  AppNotification(id: 'n2', userName: 'Juan Dela Cruz', avatarPath: _juan, type: NotificationType.comment, description: '"Ang ganda ng kulay, pre!"', date: DateTime(2026, 11, 25, 11, 42)),
  AppNotification(id: 'n3', userName: 'Bea Santos', type: NotificationType.friendRequest, description: '12 mutual friends', date: DateTime(2026, 11, 25, 10, 5)),
  AppNotification(id: 'n4', userName: 'Roben Juanatas', type: NotificationType.tag, description: '"Kicking off the holiday season with ICpEP-NCR!"', date: DateTime(2026, 11, 25, 8, 30)),
  AppNotification(id: 'n5', userName: 'Carla Mendoza', type: NotificationType.share, description: '"Tambayan v2 is live: more tabs, dynamic posts..."', date: DateTime(2026, 11, 24, 21, 0)),
  AppNotification(id: 'n6', userName: 'Miguel Reyes', type: NotificationType.birthday, description: 'Send Miguel a birthday greeting.', date: DateTime(2026, 11, 24, 7, 0)),
  AppNotification(id: 'n7', userName: 'Avengers Doomsday', avatarPath: _doomsday, type: NotificationType.mention, description: '"@Mhark you are not ready for December 18."', date: DateTime(2026, 11, 23, 19, 25), isRead: true),
  AppNotification(id: 'n8', userName: 'Patricia Lim', type: NotificationType.like, description: '"First post on Tambayan. Hello, world!"', date: DateTime(2026, 11, 23, 14, 10), isRead: true),
  AppNotification(id: 'n9', userName: 'Tambayan', type: NotificationType.memory, description: 'Your first post was 1 year ago.', date: DateTime(2026, 11, 22, 9, 0)),
  AppNotification(id: 'n10', userName: 'Kevin Ramos', type: NotificationType.comment, description: '"Pa-share naman ng source code hehe"', date: DateTime(2026, 11, 21, 22, 40), isRead: true),
  AppNotification(id: 'n11', userName: 'Angela Cruz', type: NotificationType.friendRequest, description: '4 mutual friends', date: DateTime(2026, 11, 21, 16, 15)),
  AppNotification(id: 'n12', userName: 'Juan Dela Cruz', avatarPath: _juan, type: NotificationType.share, description: '"New profile pic, who dis?"', date: DateTime(2026, 11, 20, 13, 5), isRead: true),
  AppNotification(id: 'n13', userName: 'Cyrus Robles', type: NotificationType.tag, description: '"Kamusta, mga tambay? Coffee run later after class?"', date: DateTime(2026, 11, 19, 18, 50), isRead: true),
  AppNotification(id: 'n14', userName: 'Bea Santos', type: NotificationType.like, description: '"Tambayan v2 is live: more tabs, dynamic posts..."', date: DateTime(2026, 11, 18, 10, 20), isRead: true),
  AppNotification(id: 'n15', userName: 'Paolo Garcia', type: NotificationType.mention, description: '"Ask @Mhark, siya yung backend natin."', date: DateTime(2026, 11, 15, 15, 35), isRead: true),
  AppNotification(id: 'n16', userName: 'Carla Mendoza', type: NotificationType.comment, description: '"Congrats! Ang linis ng UI."', date: DateTime(2026, 11, 12, 20, 0), isRead: true),
  AppNotification(id: 'n17', userName: 'Liza Fernandez', type: NotificationType.birthday, description: 'Send Liza a birthday greeting.', date: DateTime(2026, 11, 8, 7, 0), isRead: true),
  AppNotification(id: 'n18', userName: 'Miguel Reyes', type: NotificationType.like, description: '"First post on Tambayan. Hello, world!"', date: DateTime(2026, 11, 3, 11, 45), isRead: true),
  AppNotification(id: 'n19', userName: 'Kevin Ramos', type: NotificationType.friendRequest, description: '9 mutual friends', date: DateTime(2026, 10, 30, 17, 10), isRead: true),
  AppNotification(id: 'n20', userName: 'Tambayan', type: NotificationType.memory, description: 'See what you posted on this day last year.', date: DateTime(2026, 10, 21, 9, 0), isRead: true),
];

/// People shown on the Friends tab (taken from the friend-request notifications
/// plus a few suggestions).
const List<String> friendRequests = ['Bea Santos', 'Angela Cruz', 'Kevin Ramos'];
const List<String> friendSuggestions = [
  'Patricia Lim',
  'Paolo Garcia',
  'Liza Fernandez',
  'Miguel Reyes',
  'Carla Mendoza',
];
