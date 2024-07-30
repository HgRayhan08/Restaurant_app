import 'package:final_project_restaurant_app/data/db/database_helper.dart';
import 'package:final_project_restaurant_app/data/model/list_restaurant_response.dart';
import 'package:flutter/foundation.dart';

enum ResultState { loading, noData, hasData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getRestaurant();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  late String _message = '';
  String get message => _message;

  late List<Restaurant> _restaurant = [];
  List<Restaurant> get restaurant => _restaurant;

  void _getRestaurant() async {
    _restaurant = await databaseHelper.getRestaurant();
    if (_restaurant.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Data Kosong';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurant article) async {
    try {
      await databaseHelper.insertRestaurant(article);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isRestaurant(String id) async {
    final bookmarkedArticle = await databaseHelper.getRestaurantBYyd(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
