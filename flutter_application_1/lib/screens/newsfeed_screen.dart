import 'package:material_ui/material_ui.dart';
import 'package:flutter_application_1/widgets/newsfeed_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsfeedCard(
          userName: 'Avengers Doomsday',
          postContent: 'I am Doomsday.',
          hashtag: '#VillainsAssemble',
          date: 'December 18, 2026',
          avatarPath: 'assets/images/doomsday.jpg',
          imagePath: 'assets/images/doomsday.jpg',
          numOfLikes: 100000,
          numOfComments: 42,
          numOfShares: 5,
        ),
        // A post without an image: imagePath is left out (null),
        // so the card shows text only.
        NewsfeedCard(
          userName: 'Juan Dela Cruz',
          postContent:
              'Finally finished my Flutter lab activity! Who else is coding tonight?',
          hashtag: '#MobileProgramming',
          date: 'November 24, 2026',
          avatarPath: 'assets/images/juan.png',
          numOfLikes: 58,
          numOfComments: 3,
          numOfShares: 1,
        ),
      ],
    );
  }
}
