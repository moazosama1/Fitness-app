import 'dart:developer';

import 'package:elevate_super_fitness/core/constants/const_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: ConstKeys.keyUserToken, value: token);
    } catch (e) {
      log('SecureStorage error: $e');
      await _storage.deleteAll();
      await _storage.write(key: ConstKeys.keyUserToken, value: token);
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: ConstKeys.keyUserToken);
    } catch (e) {
      log('SecureStorage read error: $e');
      await _storage.deleteAll();
      return null;
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: ConstKeys.keyUserToken);
    } catch (e) {
      log('SecureStorage delete error: $e');
      await _storage.deleteAll();
    }
  }
}
