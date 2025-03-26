class LoginResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? data;

  LoginResponse({
    required this.success,
    this.message,
    this.data,
  });
}
