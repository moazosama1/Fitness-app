import 'package:elevate_super_fitness/core/constants/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppConfig extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage;

  String? _local;

  AppConfig(this._secureStorage);

  String? get local => _local;

  Future<void> saveLocal(String value) async {
    try {
      await _secureStorage.write(key: ConstKeys.kLocal, value: value);
    } catch (_) {
      await _secureStorage.deleteAll();
      await _secureStorage.write(key: ConstKeys.kLocal, value: value);
    }
    _local = value;
  }

  Future<void> getLocal() async {
    try {
      _local = await _secureStorage.read(key: ConstKeys.kLocal);
    } catch (_) {
      await _secureStorage.deleteAll();
      _local = null;
    }
    notifyListeners();
  }

  Future<void> changeLocal(String value) async {
    await saveLocal(value);
    notifyListeners();
  }
}
