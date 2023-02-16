import 'package:provider/provider.dart';
import 'package:testing/provider/restaurants_provider.dart';
import 'package:testing/widgets/card_restaurant.dart';
import 'package:testing/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String searchTitle = 'Search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SearchPage.searchTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(SearchPage.searchTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return ListView(
      children: [
        Material(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: CupertinoSearchTextField(
              controller: controller,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  provider.searchRestaurant(value);
                }
              },
              onSubmitted: (value) {},
            ),
          ),
        ),
        Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.stateSearch == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ));
            } else if (state.stateSearch == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.resultSearch.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.resultSearch.restaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              );
            } else if (state.stateSearch == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.messageSearch),
                ),
              );
            } else if (state.stateSearch == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.messageSearch),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
