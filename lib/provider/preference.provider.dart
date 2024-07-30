import 'package:final_project_restaurant_app/common/style.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:final_project_restaurant_app/data/preferences/preference_helper.dart';
import 'package:final_project_restaurant_app/utils/background_service.dart';
import 'package:final_project_restaurant_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getRecommendedResto();
  }

  bool _isDarkTheme = false;
  bool get isdarkTheme => _isDarkTheme;

  bool _isRecommended = false;
  bool get isRecommended => _isRecommended;

  // bool _isScheduled = false;
  // bool get isScheduled => _isScheduled;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

// mengatur tema
  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
    notifyListeners();
  }

// mengatur notifikasi

  void _getRecommendedResto() async {
    _isRecommended = await preferencesHelper.isRecommendedResto;
    notifyListeners();
  }

  void enablerecommendedResto(bool value) {
    preferencesHelper.setRecommendedResto(value);
    scheduledRestaurant(value);
    _getRecommendedResto();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isRecommended = value;
    notifyListeners();
    if (_isRecommended) {
      print('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
