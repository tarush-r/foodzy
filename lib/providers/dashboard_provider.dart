import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kjsce_hack_2022/models/recipeResultModel.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier {
  List<RandomRecipeResultModel> randomRecipes = [];
  List<dynamic> ingredientSubstitutes = [];
  bool loadingRandomRecipes = false;
  bool loadingSubstituteRecipes =  false;
  void loadRandomRecipes() async {
    randomRecipes = [];
    loadingRandomRecipes = true;
    notifyListeners();
    const String randomRecipeEndpoint =
        "https://api.spoonacular.com/recipes/random?apiKey=d815a43f7a2644dd890a44d5f835d21d&number=20";
    var response = await http.get(Uri.parse(randomRecipeEndpoint));
    var decodedResponse = json.decode(response.body);

    print(decodedResponse['recipes']);
    for (int i = 0; i < decodedResponse['recipes'].length; i++) {
      randomRecipes
          .add(RandomRecipeResultModel.fromMap(decodedResponse['recipes'][i]));
    }
    // decodedResponse['recipes'].map((element) {
    //   randomRecipes.add(RandomRecipeResultModel.fromMap(element));
    // });
    print(randomRecipes);
    loadingRandomRecipes = false;
    notifyListeners();
  }

  Future<List<dynamic>> substituteIngredients(String ingredient) async {
    ingredientSubstitutes = [];
    loadingSubstituteRecipes = true;
    notifyListeners();
    String substituteRecipeEndpoint =
        "https://api.spoonacular.com/food/ingredients/substitutes?apiKey=d815a43f7a2644dd890a44d5f835d21d&ingredientName="+ingredient;
    var response = await http.get(Uri.parse(substituteRecipeEndpoint));
    var decodedResponse = json.decode(response.body);

    print(decodedResponse['substitutes']);
    ingredientSubstitutes = decodedResponse['substitutes'];
    loadingSubstituteRecipes = false;
    notifyListeners();
    return ingredientSubstitutes;
  }

  Future<String> getFoodTrivia() async {
    String randomTrivia;
    notifyListeners();
    String triviaEndpoint =
        "https://api.spoonacular.com/food/trivia/random?apiKey=d815a43f7a2644dd890a44d5f835d21d&number=20";
    var response = await http.get(Uri.parse(triviaEndpoint));
    var decodedResponse = json.decode(response.body);
    print(decodedResponse['text']);
    randomTrivia = decodedResponse['substitutes'];
    notifyListeners();
    return randomTrivia;
  }

  Future<String> getFoodJoke() async {
    String randomJoke;
    notifyListeners();
    String jokeEndpoint =
        "https://api.spoonacular.com/food/jokes/random?apiKey=d815a43f7a2644dd890a44d5f835d21d&number=20";
    var response = await http.get(Uri.parse(jokeEndpoint));
    var decodedResponse = json.decode(response.body);
    print(decodedResponse['text']);
    randomJoke = decodedResponse['substitutes'];
    notifyListeners();
    return randomJoke;
  }

}
