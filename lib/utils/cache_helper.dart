import 'package:shared_preferences/shared_preferences.dart';

Future<void> cacheJokes(List<String> jokes) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('cached_jokes', jokes);
}

Future<List<String>> getCachedJokes() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('cached_jokes') ?? [];
}
