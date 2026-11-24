# Fcebook_Clone

A Facebook newsfeed clone built with Flutter.

## Lab Activity 1: discussion

### Laboratory Discussion: How I integrated the Image into `newsfeed_card.dart` and made it dynamic

**1. I made the image path a parameter of the card.**
Before, the card had a `bool? hasImage`, and the image path `'assets/images/doomsday.jpg'` was hardcoded inside the card. That meant every post with `hasImage: true` showed the same picture. I replaced it with a nullable `String? imagePath`:

```dart
final String? imagePath; // null = no image
```

Each post now passes its own image, or leaves it out:

```dart
NewsfeedCard(userName: 'Avengers Doomsday', imagePath: 'assets/images/doomsday.jpg', ...) // with image
NewsfeedCard(userName: 'Juan Dela Cruz', postContent: '...')                             // text only
```

**2. I show the image only when there is one.**
Inside the card's `Column`, I used a collection `if`. When `imagePath` is `null`, the image widget is not built at all, so a text-only post has no empty space where the image would be:

```dart
if (widget.imagePath != null) PostImage(imagePath: widget.imagePath!),
```

This replaces the old ternary `hasImage == true ? Image(...) : const SizedBox.shrink()`. It is shorter, and it doesn't need an empty placeholder widget.

**3. I moved the image into its own widget, `PostImage`, which uses the Image class.**
`PostImage` uses `Image.asset(imagePath)` with `width: double.infinity` and `fit: BoxFit.cover`, so any picture fills the width of the card. Two `Image` callbacks make it safer:
- `errorBuilder` shows a grey "broken image" box if the file path is wrong, instead of crashing the app.
- `frameBuilder` fades the image in when it finishes loading.

Because the image is now a parameter, to add a new post with a different picture I only have to put the file in `assets/images/` (already listed in `pubspec.yaml`) and pass its path. The card itself doesn't need to change.

For this activity I enhanced the newsfeed post card so it looks closer to a real Facebook post. Instead of writing everything inside one big widget, I split the card into smaller reusable widgets.

### Enhancement 1: Widget for the image area
I created a `PostImage` widget (`lib/widgets/post_image.dart`) for the post's image. It uses the **Image class** (`Image.asset`) from the Flutter widgets library:
- `fit: BoxFit.cover` and `width: double.infinity` make the image fill the card's width.
- `frameBuilder` fades the image in once it has loaded.
- `errorBuilder` shows a placeholder icon instead of crashing if the image file is missing.
- Tapping the image opens it full screen, where it can be zoomed with `InteractiveViewer`. A `Hero` animation makes the transition smooth.

### Enhancement 2: Avatar for the user profile image
I replaced the plain `Icon(Icons.person)` with a `UserAvatar` widget (`lib/widgets/user_avatar.dart`) built on `CircleAvatar`. When a profile picture is given (`avatarPath`), it is cropped into a circle with `AssetImage`. When there is no picture, the avatar shows the user's initials on a colored circle. I also used this widget in the "Write a comment..." row.

### Enhancement 3: Widget-based Like, Comment and Share buttons
I created a reusable `PostActionButton` widget (`lib/widgets/post_action_button.dart`) to replace the three `TextButton.icon` buttons. It uses `Expanded` so the three buttons share the row equally, and `InkWell` for the tap ripple.
- `NewsfeedCard` is now a `StatefulWidget`, so tapping **Like** updates the screen with `setState()`. The like count goes up by one, and the button turns blue. Tapping again un-likes the post.
- **Comment** moves the cursor to the "Write a comment..." field. Sending a comment increases the comment count.
- **Share** increases the share count and shows a SnackBar.
- Above the buttons there is a summary row with the number of likes, comments and shares (e.g. 100K, 42 Comments, 5 Shares), like in the reference design.

### What I learned
Breaking the UI into small widgets makes the code easier to read and reuse. The same `UserAvatar` and `PostActionButton` can now be used in any other screen. I also learned the difference between a `StatelessWidget` and a `StatefulWidget`: the card needed state so the like count could change when the user taps the button.
