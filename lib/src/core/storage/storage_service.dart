import 'package:movie_recommender_app/src/core/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService<T> implements Storage {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  @override
  String? getItem(String key) => _prefs.getString(key);

  @override
  Future<bool> setItem(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}
