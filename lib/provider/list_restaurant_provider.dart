import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/data/model/list_restaurant_response.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestaurantProvider extends ChangeNotifier {
  late RestaurantApi restaurantApi;

  ListRestaurantProvider({required this.restaurantApi}) {
    _fetchAllRestaurant();
  }

  // deklarasi yang tidak dapat di akses diluar class
  late ListRestaurantResponse _responseRestaurant;
  late ResultState _state;
  String _message = "";

  //Deklarasi yang dapat diakses diluar class
  ListRestaurantResponse get responseRestaurang => _responseRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final dataRestaurant = await restaurantApi.getRestaurant();
      if (dataRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "restaurant yang anda cari tidak ada";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _responseRestaurant = dataRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Jaringan Seruler Tidak Tersedia";
    }
  }
}
