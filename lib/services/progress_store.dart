import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static const completedKey = 'completed_exercises';
  static const attemptPrefix = 'attempts_';

  Future<Set<String>> completed() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(completedKey) ?? const <String>[]).toSet();
  }

  Future<void> record(String id, {required bool correct}) async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = prefs.getInt('$attemptPrefix$id') ?? 0;
    await prefs.setInt('$attemptPrefix$id', attempts + 1);
    if (!correct) return;
    final done = (prefs.getStringList(completedKey) ?? const <String>[]).toSet()..add(id);
    await prefs.setStringList(completedKey, done.toList()..sort());
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    for (final key in prefs.getKeys().where((k) => k == completedKey || k.startsWith(attemptPrefix)).toList()) {
      await prefs.remove(key);
    }
  }
}