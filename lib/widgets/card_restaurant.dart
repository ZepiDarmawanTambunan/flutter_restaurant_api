import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:testing/common/styles.dart';
import 'package:testing/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:testing/provider/restaurants_provider.dart';
import 'package:testing/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);
    return Material(
      color: primaryColor,
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Hero(
            tag: restaurant.id,
            child: CachedNetworkImage(
              imageUrl: restaurant.smallPicture,
              fit: BoxFit.cover,
              width: 100,
              placeholder: (context, url) => const LinearProgressIndicator(
                backgroundColor: Colors.red,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(
            restaurant.name,
          ),
          subtitle: Text(restaurant.city),
          onTap: () {
            provider.fetchDetailRestaurant(restaurant.id);
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments: restaurant.id,
            );
          }),
    );
  }
}
