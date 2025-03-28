import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final _storage = FlutterSecureStorage();
  static const _key = 'auth_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
  }
}
