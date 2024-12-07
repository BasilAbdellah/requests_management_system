import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServiceJWT {
  // Instance of FlutterSecureStorage
  static const _secureStorage = FlutterSecureStorage();

  // Keys
  static const _tokenKey = 'auth_token';

  // Save the token
  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    print("Token saved: $token");
  }

  // Retrieve the token
  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Delete the token (for logout)
  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
