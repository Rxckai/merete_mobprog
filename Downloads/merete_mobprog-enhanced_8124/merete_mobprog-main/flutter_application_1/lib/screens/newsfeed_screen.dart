import 'package:material_ui/material_ui.dart';
import 'package:flutter_application_1/data/dummy_data.dart';
import 'package:flutter_application_1/widgets/newsfeed_card.dart';

/// The Home tab. Builds one NewsfeedCard per post in the data list, so
/// adding an 11th post only means adding it to `posts` in dummy_data.dart.
class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => NewsfeedCard(
        key: ValueKey(posts[index].id),
        post: posts[index],
      ),
    );
  }
}
