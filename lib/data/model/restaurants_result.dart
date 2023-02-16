import 'package:testing/data/model/restaurant.dart';

class RestaurantsResult {
  RestaurantsResult({
    required this.error,
    this.message,
    this.founded,
    this.count,
    required this.restaurants,
  });

  bool error;
  String? message;
  int? count;
  int? founded;
  List<Restaurant> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
