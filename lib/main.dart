// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:final_project_restaurant_app/data/db/database_helper.dart';
import 'package:final_project_restaurant_app/data/preferences/preference_helper.dart';
import 'package:final_project_restaurant_app/page/bottom_navigasi.dart';
import 'package:final_project_restaurant_app/provider/database_provider.dart';
import 'package:final_project_restaurant_app/provider/preference.provider.dart';
import 'package:final_project_restaurant_app/utils/background_service.dart';
import 'package:final_project_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sheredPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.themeData,
            debugShowCheckedModeBanner: false,
            home: const BottomNavigasi(),
          );
        },
      ),
    );
  }
}
