import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsLocalStorage<T> {
  @override
  Future<T?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(key);
    if (json != null) {
      return jsonDecode(json) as T;
    }
    return null;
  }

  @override
  Future<void> save(String key, T object) async {
    String json = jsonEncode(object);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json);
  }

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
