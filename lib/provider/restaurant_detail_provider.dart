import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  late RestaurantApi restaurantApi;
  String id;
  DetailRestaurantProvider({required this.restaurantApi, required this.id}) {
    _fetchDetail(id);
  }

  late DetailRestaurantResponse _responseDetail;
  late ResultState _state;
  String _message = "";

  DetailRestaurantResponse get responseDetail => _responseDetail;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic>? _fetchDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await restaurantApi.getDetailRestaurant(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "restaurant yang anda cari tidak ada";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _responseDetail = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Jaringan Seruler Tidak Tersedia";
    }
  }
}
