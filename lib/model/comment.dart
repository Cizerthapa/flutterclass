class Comment {
  final int id;
  final String body;
  final String user;

  Comment({
    required this.id,
    required this.body,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        body: json['body'],
        user: json['user']['username'],
      );
}
