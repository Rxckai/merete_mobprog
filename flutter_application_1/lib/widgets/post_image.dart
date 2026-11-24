import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Enhancement 1: the post's image area as its own reusable widget.
///
/// Uses the Image class (Image.asset) with:
///  - a fade-in while the image loads (frameBuilder)
///  - a fallback box if the file is missing (errorBuilder)
///  - tap to open the image full screen with pinch-to-zoom
class PostImage extends StatelessWidget {
  final String imagePath;

  const PostImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Hero(
        tag: imagePath,
        child: Image.asset(
          imagePath,
          width: double.infinity,
          fit: BoxFit.cover,
          // Fade the image in once its first frame is ready.
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: child,
            );
          },
          // Show a placeholder instead of crashing if the image can't load.
          errorBuilder: (context, error, stackTrace) => Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(200),
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.grey, size: 48),
          ),
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: Hero(
              tag: imagePath,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
