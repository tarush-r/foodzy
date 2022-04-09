import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeDetails{
  final String title;
  // final String summary;
  final int servings;
  final int time;
  final List extendedIngredients;
  final String instructions;
  final String instructionsUrl;
  // final List<String> ingredients;
  // final List<String> ingredient_quantities;
  final String imageUrl;

  RecipeDetails({this.title,this.time,this.imageUrl,this.servings,this.extendedIngredients,this.instructions,this.instructionsUrl});

  factory RecipeDetails.fromJson(Map<String,dynamic> json){
    return RecipeDetails(title:json["title"], time:json["readyInMinutes"], imageUrl:json["image"], extendedIngredients:json['extendedIngredients'], servings:json["servings"],instructions: json['instructions'],instructionsUrl: json["sourceUrl"]);
  }


}