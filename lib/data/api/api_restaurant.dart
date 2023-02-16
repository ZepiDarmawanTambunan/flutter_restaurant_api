import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/data/model/restaurant_detail.dart';
import 'package:testing/data/model/restaurants_result.dart';

class ApiRestaurant {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> getList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Failed to load top headlines");
    }
  }

  Future<RestaurantDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Failed to load top headlines");
    }
  }

  Future<RestaurantsResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Failed to load top headlines");
    }
  }
}
