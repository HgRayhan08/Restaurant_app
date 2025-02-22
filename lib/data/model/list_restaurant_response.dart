// To parse this JSON data, do
//
//     final listRestaurantResponse = listRestaurantResponseFromJson(jsonString);

import 'dart:convert';

ListRestaurantResponse listRestaurantResponseFromJson(String str) =>
    ListRestaurantResponse.fromJson(json.decode(str));

String listRestaurantResponseToJson(ListRestaurantResponse data) =>
    json.encode(data.toJson());

class ListRestaurantResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  ListRestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: double.parse(json["rating"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
