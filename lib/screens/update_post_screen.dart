import 'package:classapp/service/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/post.dart';

class UpdatePostScreen extends StatefulWidget {
  final Post post;

  const UpdatePostScreen({super.key, required this.post});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool _isLoading = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.post.title);
    _bodyController = TextEditingController(text: widget.post.body);
    super.initState();
  }

  Future<void> _updatePost() async {
    setState(() => _isLoading = true);

    final token = await TokenStorage.getToken();

    final response = await http.put(
      Uri.parse("https://dummyjson.com/posts/${widget.post.id}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "title": _titleController.text.trim(),
        "body": _bodyController.text.trim(),
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Updated!"),
          content: const Text("Post updated Sucessfully"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text("Failed to update post.\n${response.body}"),
          actions: [
            CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Edit Post")),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _titleController,
                placeholder: "Title",
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _bodyController,
                placeholder: "Body",
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CupertinoActivityIndicator()
                  : CupertinoButton.filled(
                      onPressed: _updatePost,
                      child: const Text("Update"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
