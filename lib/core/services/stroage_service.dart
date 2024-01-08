import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._privateConstructor();
  factory StorageService() {
    return _instance;
  }
  late SharedPreferences _prefs;

  StorageService._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  Object? getData(String key) {
    final result = _prefs.get(key);
    return result;
  }

  Future<void> setInt(String key, int data) async {
    await _prefs.setInt(key, data);
  }

  Future<void> setString(String key, String data) async {
    await _prefs.setString(key, data);
  }

  Future<void> deleteData(String key) async {
    await _prefs.remove(key);
  }
}
