import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/data/model/search_restaurant_response.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error, kosong }

class SearchRestaurantProvider extends ChangeNotifier {
  late RestaurantApi restaurantApi;
  String? inputNamaPencarin;

  SearchRestaurantProvider({required this.restaurantApi}) {
    _fetchAllSearch(input);
  }

  late SearchRestaurantResponse _responseSearch;
  late ResultState _state;
  String _message = "";
  final String _input = "";

  bool _isHideSearch = false;
  bool get isHideSearch => _isHideSearch;

  SearchRestaurantResponse get resultSearch => _responseSearch;
  ResultState get state => _state;
  String get message => _message;
  String get input => _input;

  void searchInput(String value) {
    inputNamaPencarin = value;
    _isHideSearch = true;
    _fetchAllSearch(value);
    notifyListeners();
  }

  void hideSearch() {
    _isHideSearch = false;
    notifyListeners();
  }

  Future<dynamic> _fetchAllSearch(String value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchData = await restaurantApi.getSearchRestaurant(value);
      if (searchData.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "restaurant yang anda cari tidak ada";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _responseSearch = searchData;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Jaringan Seruler Tidak Tersedia";
    }
  }
}
