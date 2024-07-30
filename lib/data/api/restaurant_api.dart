import 'package:dio/dio.dart';
import 'package:final_project_restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:final_project_restaurant_app/data/model/list_restaurant_response.dart';
import 'package:final_project_restaurant_app/data/model/search_restaurant_response.dart';

class RestaurantApi {
  Future<ListRestaurantResponse> getRestaurant() async {
    final response = await Dio().get(
      "https://restaurant-api.dicoding.dev/list",
    );
    return ListRestaurantResponse.fromJson(response.data);
  }

  Future<SearchRestaurantResponse> getSearchRestaurant(String nilai) async {
    final response = await Dio().get(
      "https://restaurant-api.dicoding.dev/search?q=$nilai",
    );
    return SearchRestaurantResponse.fromJson(response.data);
  }

// get detail
  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await Dio().get(
      "https://restaurant-api.dicoding.dev/detail/$id",
    );
    return DetailRestaurantResponse.fromJson(response.data);
  }
}
