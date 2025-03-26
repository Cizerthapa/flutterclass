import 'package:classapp/service/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("https://dummyjson.com/posts/add"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "title": _titleController.text.trim(),
        "body": _bodyController.text.trim(),
        "userId": 1,
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Success"),
          content: const Text("Post added successfully."),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
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
          content: Text("Failed to create post.\n${response.body}"),
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
      navigationBar: const CupertinoNavigationBar(middle: Text("Add Post")),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CupertinoTextFormFieldRow(
                  controller: _titleController,
                  placeholder: "Title",
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter title' : null,
                ),
                CupertinoTextFormFieldRow(
                  controller: _bodyController,
                  placeholder: "Body",
                  maxLines: 5,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter body' : null,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CupertinoActivityIndicator()
                    : CupertinoButton.filled(
                        onPressed: _submitPost,
                        child: const Text("Submit"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
