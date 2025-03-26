import 'dart:convert';
import 'package:classapp/model/login_response.dart';
import 'package:classapp/service/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static const String _loginUrl = 'https://dummyjson.com/auth/login';
  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  static Future<LoginResponse> loginUser(String email, String password) async {
    debugPrint("Login attempt with email: $email");

    if (email.isEmpty || password.isEmpty) {
      debugPrint("Email or password is empty.");
      return LoginResponse(
        success: false,
        message: "Email and password must not be empty.",
      );
    }

    final body = jsonEncode({"username": email, "password": password});
    debugPrint("Sending POST request to $_loginUrl with body: $body");

    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: _headers,
        body: body,
      );

      debugPrint("HTTP status code: ${response.statusCode}");
      debugPrint("Raw response body: ${response.body}");

      debugPrint("Login API Response: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("Login successful. Parsing response...");
        final data = jsonDecode(response.body);

        final token = data['accessToken'];
        debugPrint("Extracted token: $token");

        if (token != null && token is String) {
          await TokenStorage.saveToken(token);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", token);
          debugPrint("Token saved to SharedPreferences.");
          debugPrint("TOKEN SAVED: $token");

          return LoginResponse(
            success: true,
            data: data,
          );
        } else {
          debugPrint("Token not found in response.");
          return LoginResponse(
            success: false,
            message: "Login succeeded but no token found.",
          );
        }
      }
    } catch (e) {
      debugPrint("Exception during login: $e");
      debugPrint("Login Error: $e");
      return LoginResponse(
        success: false,
        message: "An error occurred during login. Please try again.",
      );
    }
    throw Exception("Login failed unexpectedly.");
  }
}
