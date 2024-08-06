const String kMovies = 'movies';

abstract class Storage {
  String? getItem(String key);
  Future<bool> setItem(String key, String value);
  Future<bool> remove(String key);
}
