import 'package:flutter/foundation.dart';
import 'package:testing/data/api/api_restaurant.dart';
import 'package:testing/data/model/restaurant_detail.dart';
import 'package:testing/data/model/restaurants_result.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  RestaurantProvider() {
    _fetchAllRestaurant();
  }

  late RestaurantDetail _restaurantDetail;
  late RestaurantsResult _restaurantResult;
  late RestaurantsResult _restaurantSearch;

  String _message = '';
  late ResultState _state;

  String _messageSearch = 'Empty Data';
  late ResultState _stateSearch = ResultState.noData;

  RestaurantsResult get result => _restaurantResult;
  RestaurantsResult get resultSearch => _restaurantSearch;
  RestaurantDetail get resultDetail => _restaurantDetail;

  String get message => _message;
  ResultState get state => _state;

  String get messageSearch => _messageSearch;
  ResultState get stateSearch => _stateSearch;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiRestaurant().getList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Please close this app and try again.\n Error Message --> $e';
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiRestaurant().getDetail(id);
      if (restaurant == null || restaurant == "") {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Please close this app and try again.\n Error Message --> $e';
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _stateSearch = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiRestaurant().searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _stateSearch = ResultState.noData;
        notifyListeners();
        return _messageSearch = 'Empty Data';
      } else {
        _stateSearch = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } catch (e) {
      _stateSearch = ResultState.error;
      notifyListeners();
      return _messageSearch =
          'Please close this app and try again.\n Error Message --> $e';
    }
  }
}
