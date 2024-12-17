part of 'model.dart';

class Recipe {
  final String title;
  final String image;
  final String id;
  final String imageType;

  Recipe({required this.id, required this.title, required this.image, required this.imageType});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['title'],
      title: json['title'],
      image: json['image'],
      imageType: json['image'],

    );
  }
}
