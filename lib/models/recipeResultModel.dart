import 'package:cloud_firestore/cloud_firestore.dart';

class RandomRecipeResultModel {
  int id;
  String title;
  String imageUrl;
  String description;
  bool isVegetarian;
  int cookingTime;
  List ingredients;

  RandomRecipeResultModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.isVegetarian,
    this.cookingTime,
    this.ingredients,
  });

  factory RandomRecipeResultModel.fromMap(Map doc) {
    return RandomRecipeResultModel(
      id: doc['id'],
      title: doc['title'],
      description: doc['summary'],
      imageUrl: doc['image'],
      isVegetarian: doc['vegetarian'],
      cookingTime: doc['readyInMinutes'],
      ingredients: doc['extended_ingredients'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['thumbnail_image_url'] = this.thumbnailImageUrl;
  //   data['video_url'] = this.videoUrl;
  //   data['trainer_id'] = this.trainerId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['type'] = this.type;
  //   return data;
  // }
}
