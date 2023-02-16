class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.rating,
    required this.smallPicture,
    required this.largePicture,
  });

  String id;
  String name;
  String description;
  String city;
  double rating;
  String smallPicture;
  String largePicture;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        smallPicture:
            "https://restaurant-api.dicoding.dev/images/small/${json['pictureId']}",
        largePicture:
            "https://restaurant-api.dicoding.dev/images/large/${json['pictureId']}",
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
