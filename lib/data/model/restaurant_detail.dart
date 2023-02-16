import 'package:testing/data/model/category.dart';
import 'package:testing/data/model/customer_review.dart';
import 'package:testing/data/model/menus.dart';
import 'package:testing/data/model/restaurant.dart';

class RestaurantDetail extends Restaurant {
  String message;
  bool error;
  String address;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.rating,
    required super.smallPicture,
    required super.largePicture,
    required this.message,
    required this.error,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["restaurant"]["id"],
        error: json["error"],
        message: json["message"],
        name: json["restaurant"]["name"],
        description: json["restaurant"]["description"],
        city: json["restaurant"]["city"],
        address: json["restaurant"]["address"],
        categories: List<Category>.from(
            (json["restaurant"]["categories"] as List)
                .map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["restaurant"]["menus"]),
        rating: json["restaurant"]["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            (json["restaurant"]["customerReviews"] as List)
                .map((x) => CustomerReview.fromJson(x))),
        smallPicture:
            "https://restaurant-api.dicoding.dev/images/small/${json['restaurant']['pictureId']}",
        largePicture:
            "https://restaurant-api.dicoding.dev/images/large/${json['restaurant']['pictureId']}",
      );
}
