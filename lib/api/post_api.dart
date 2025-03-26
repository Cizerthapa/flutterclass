import 'package:classapp/model/post.dart';
import 'package:classapp/service/token_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostApi {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Post>> fetchPosts({int limit = 10, int skip = 0}) async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/posts?limit=$limit&skip=$skip'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final posts = List<Post>.from(data['posts'].map((p) => Post.fromJson(p)));
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<bool> deletePost(int postId) async {
    final token = await TokenStorage.getToken();

    final response = await http.delete(
      Uri.parse("https://dummyjson.com/posts/$postId"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }
}
