import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/data/db/database_helper.dart';
import 'package:final_project_restaurant_app/page/bookmark/bookmark_page.dart';
import 'package:final_project_restaurant_app/page/restaurant/detail_restaurant_page.dart';
import 'package:final_project_restaurant_app/provider/database_provider.dart';
import 'package:final_project_restaurant_app/provider/list_restaurant_provider.dart';
import 'package:final_project_restaurant_app/page/restaurant/list_restaurant_page.dart';
import 'package:final_project_restaurant_app/page/settings/settings_page.dart';
import 'package:final_project_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigasi extends StatefulWidget {
  static const routeName = "/BottomNavigasi";
  const BottomNavigasi({super.key});

  @override
  State<BottomNavigasi> createState() => _BottomNavigasiState();
}

class _BottomNavigasiState extends State<BottomNavigasi> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) => ListRestaurantProvider(restaurantApi: RestaurantApi()),
      child: const ListRestaurantPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: const BookMarkPage(),
    ),
    const SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      DetailRestaurantPage.routeName,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
