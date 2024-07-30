import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sheredPreferences;

  PreferencesHelper({required this.sheredPreferences});

  static const darkTheme = "DARK_THEME";
  static const recommendedResto = "RECOMENDED_RESTAURANT";

  Future<bool> get isDarkTheme async {
    final prefs = await sheredPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sheredPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isRecommendedResto async {
    final prefs = await sheredPreferences;
    return prefs.getBool(recommendedResto) ?? false;
  }

  void setRecommendedResto(bool value) async {
    final prefs = await sheredPreferences;
    prefs.setBool(recommendedResto, value);
  }
}
