import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  static const _settingsKey = 'app_settings';
  static const _userKey = 'current_user';

  String? readSettings() => _prefs.getString(_settingsKey);

  Future<void> saveSettings(Map<String, dynamic> json) async {
    await _prefs.setString(_settingsKey, jsonEncode(json));
  }

  String? readUser() => _prefs.getString(_userKey);

  Future<void> saveUser(Map<String, dynamic> json) async {
    await _prefs.setString(_userKey, jsonEncode(json));
  }

  Future<void> clearUser() async => _prefs.remove(_userKey);
}
