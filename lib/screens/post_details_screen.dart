import 'package:classapp/api/post_api.dart';
import 'package:classapp/model/post.dart';
import 'package:classapp/screens/comments_screen.dart';
import 'package:classapp/screens/update_post_screen.dart';
import 'package:flutter/cupertino.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  void _confirmDelete(BuildContext context, int postId) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context); // Close confirmation dialog

              final success = await PostApi.deletePost(postId);

              if (success) {
                _showDialog(context, "Deleted", "Post deleted successfully.");
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context); // Go back to previous screen
                });
              } else {
                _showDialog(context, "Error", "Failed to delete post.");
              }
            },
            child: const Text("Delete"),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(post.title),
        previousPageTitle: "Back",
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                post.body,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                child: const Text("View Comments"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => CommentsScreen(postId: post.id),
                    ),
                  );
                },
              ),
              CupertinoButton(
                child: const Text("Edit"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => UpdatePostScreen(post: post),
                    ),
                  );
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Icon(
                  CupertinoIcons.delete,
                  color: CupertinoColors.systemRed,
                ),
                onPressed: () => _confirmDelete(context, post.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
