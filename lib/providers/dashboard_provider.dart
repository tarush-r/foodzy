import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kjsce_hack_2022/models/recipeResultModel.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier {
  List<RandomRecipeResultModel> randomRecipes = [];
  bool loadingRandomRecipes = false;

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
}
