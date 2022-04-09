import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kjsce_hack_2022/models/recipe_details.dart';
import 'package:kjsce_hack_2022/utils/size_config.dart';

import '../widgets/buttons.dart';

class RecipeDetailScreen extends StatefulWidget {
  final foodId;

  RecipeDetailScreen(this.foodId, {Key key}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isLoading;
  RecipeDetails recipeData;
  final apiKey = "d815a43f7a2644dd890a44d5f835d21d";
  List<String> ingredients = [];
  final instructions = '';


  Future<RecipeDetails> fetchRecipeDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/' +
            this.widget.foodId +
            '/information?apiKey=' +
            this.apiKey +
            '&includeNutrition=false'));
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return RecipeDetails.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  initData() async {
    setState(() {
      isLoading = true;
    });
    recipeData = await fetchRecipeDetails();
    setState(() {
      isLoading = false;
    });
  }

  String instructionFinal() {
    if (recipeData.instructions == '' && recipeData.instructionsUrl == '') {
      return "No instructions available";
    }
    if (recipeData.instructions == '') {
      return recipeData.instructionsUrl;
    }

    return recipeData.instructions;
  }

  String ingredientsFinal(String input) {
    var array = recipeData.extendedIngredients;
    String ok = '';
    for (int i = 0; i < array.length; i++) {
      ok += array[i][input] + ',';
    }

    print(recipeData.extendedIngredients);

    return ok;
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initData();
    });
    // print(recipeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : mainPage(),
    );
  }

  Widget mainPage() {
    return Stack(
      children: <Widget>[
        buildBackground(recipeData.imageUrl),
        Align(

          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            height: SizeConfig.screenHeight * 0.6,
            child: Column(
              children: [
                Text(recipeData.title),
                Text("Servings: " + (recipeData.servings).toString()),
                Text("Cook duration: " +
                    (recipeData.time).toString() +
                    " minutes"),
                Text("Ingredients: " + ingredientsFinal('originalName')),
                // SizedBox(
                //   height: 50,
                // ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.4,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        toolbarHeight: 1,
                        bottom: TabBar(
                          tabs: [
                            Tab(child: Text("Ingredients",
                              style: TextStyle(color: Colors.black),),),
                            Tab(child: Text("Instructions",
                              style: TextStyle(color: Colors.black),),),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          Text(ingredientsFinal('original')),
                          Text(instructionFinal())
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget buildBackground(String url) {
    return Image.network(url);
  }


}