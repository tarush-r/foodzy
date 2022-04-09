import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kjsce_hack_2022/models/recipe_details.dart';

import '../widgets/buttons.dart';


class RecipeDetailScreen extends StatefulWidget {
  final foodId;

  RecipeDetailScreen(this.foodId, {Key key})  : super(key: key);
  static const apiKey="21725763e0f44f30a833ef19fd9a0a2e";

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Future<RecipeDetails> fetchRecipeDetails() async {
    final response = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/'+this.widget.foodId+'/information?apiKey=21725763e0f44f30a833ef19fd9a0a2e&includeNutrition=false'));
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
  Future<RecipeDetails> recipeData;

  @override
  void initState(){
    super.initState();
    recipeData=fetchRecipeDetails();
    print(recipeData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children:[new FutureBuilder(
            future: recipeData,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return RecipePage(snapshot.data);
              }else if(snapshot.hasError){
                return new Text("Error ${snapshot.error}");
              }
            })]

    );
  }

  Widget RecipePage(var RecipeData){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Row(

          )
          Text("Title: "+ RecipeData.title,),
        ]
    );

  }
}
