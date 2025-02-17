import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

//! this method to put data in local database using key

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

//! this method to get data already saved in local database

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//! remove data using specific key

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//! this method to check if local database contains {key}
  static Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  static Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }

//! this fun to put data in local data base using key
  static Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }
}

class AuthServiceJWT {
  // Instance of FlutterSecureStorage
  static const _secureStorage = FlutterSecureStorage();

  // Save the token
  static Future<void> saveToken(String tokenKey, String newToken) async {
    await _secureStorage.write(key: tokenKey, value: newToken);
  }

  // Retrieve the token
  static Future<String?> getToken(String tokenKey) async {
    return await _secureStorage.read(key: tokenKey);
  }

  // Delete the token (for logout)
  static Future<void> deleteToken(String tokenKey) async {
    await _secureStorage.delete(key: tokenKey);
  }
  // update 
  static Future<void> updateToken(String tokenKey, String token) async {
    await _secureStorage.delete(key: tokenKey);
    await _secureStorage.write(key: tokenKey, value: token);
  }
}
