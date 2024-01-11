import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<void> saveExercises(List<String> exercises, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedExercises_$username', exercises);
  }

  Future<void> saveExercise(String exerciseName, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedExercises =
        prefs.getStringList('savedExercises_$username') ?? [];

    if (!savedExercises.contains(exerciseName)) {
      savedExercises.add(exerciseName);
      await prefs.setStringList('savedExercises_$username', savedExercises);
    } else {
      savedExercises.remove(exerciseName);
      await prefs.setStringList('savedExercises_$username', savedExercises);
    }
  }

  Future<List<String>> getSavedExercises(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedExercises =
        prefs.getStringList('savedExercises_$username');
    return savedExercises ?? [];
  }

  void printSavedExercises(String username) async {
    List<String> savedExercises = await getSavedExercises(username);
    print(savedExercises);
  }
}

class UserPreferences {
  static const String _kHeightKey = 'height';
  static const String _kWeightKey = 'weight';
  static const String _kAgeKey = 'age';
  static const String _kGenderKey = 'gender';
  static Future<void> saveUserPreferences({
    required String username,
    required int height,
    required int weight,
    required int age,
    required String gender,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(username + _kHeightKey, height);
    await prefs.setInt(username + _kWeightKey, weight);
    await prefs.setInt(username + _kAgeKey, age);
    await prefs.setString(username + _kGenderKey, gender);
  }

  static Future<Map<String, dynamic>> getUserPreferences(
      String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? height = prefs.getInt(username + _kHeightKey);
    final int? weight = prefs.getInt(username + _kWeightKey);
    final int? age = prefs.getInt(username + _kAgeKey);
    final String? gender = prefs.getString(username + _kGenderKey);

    return {
      'height': height ?? 0,
      'weight': weight ?? 0,
      'age': age ?? 0,
      'gender': gender ?? '',
    };
  }
}
