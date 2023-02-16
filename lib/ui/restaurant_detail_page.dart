import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:testing/data/api/api_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:testing/data/model/restaurant_detail.dart';
import 'package:testing/provider/restaurants_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<RestaurantDetail> _restraurantDetail;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _restraurantDetail = ApiRestaurant().getDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: Consumer<RestaurantProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ));
        } else if (state.state == ResultState.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: state.resultDetail.id,
                  child: CachedNetworkImage(
                    imageUrl: state.resultDetail.largePicture,
                    height: 300,
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.resultDetail.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      Text('City: ${state.resultDetail.city}'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Rating: ${state.resultDetail.rating}'),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.resultDetail.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const Text(
                        "Restaurant Category",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView.separated(
                            controller: _scrollController,
                            itemCount: state.resultDetail.categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var dataCategory =
                                  state.resultDetail.categories[index];
                              return Container(
                                color: Colors.amber,
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  dataCategory.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const Text(
                        "Customer Review",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount:
                                state.resultDetail.customerReviews.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var dataCustomerReview =
                                  state.resultDetail.customerReviews[index];
                              return Container(
                                width: 250,
                                margin: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataCustomerReview.name,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      dataCustomerReview.review,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      dataCustomerReview.date,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const Text(
                        "Food Menu",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView.separated(
                            controller: _scrollController,
                            itemCount: state.resultDetail.menus.foods.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var dataFood =
                                  state.resultDetail.menus.foods[index];
                              return Container(
                                color: Colors.greenAccent,
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  dataFood.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const Text(
                        "Drink Menu",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView.separated(
                            controller: _scrollController,
                            itemCount: state.resultDetail.menus.drinks.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var dataDrink =
                                  state.resultDetail.menus.drinks[index];
                              return Container(
                                color: Colors.blueAccent,
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  dataDrink.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      }),
    );
  }
}
