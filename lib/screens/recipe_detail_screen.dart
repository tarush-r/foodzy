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
  bool isLoading = true;
  RecipeDetails recipeData;
  final apiKey = "d815a43f7a2644dd890a44d5f835d21d";
  List<String> ingredients = [];
  final instructions = '';

  Future<RecipeDetails> fetchRecipeDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/' +
            this.widget.foodId.toString() +
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
      ok += array[i][input] + '\n';
    }

    print(recipeData.extendedIngredients);

    return ok;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
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
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(child: mainPage()),
    );
  }

  Widget mainPage() {
    return Stack(
      children: <Widget>[
        buildBackground(recipeData.imageUrl),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              height: SizeConfig.screenHeight * 0.6,
              child: Column(
                // crossAxisAlignment: CrossA,
                children: [
                  Text(
                    recipeData.title,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "Servings: " + (recipeData.servings).toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  Text(
                    // "Cook duration: " +
                    (recipeData.time).toString() + " minutes",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  //Text("Ingredients: " + ingredientsFinal('originalName'),style: TextStyle(fontSize: 15),),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          toolbarHeight: 1,
                          bottom: TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  "Ingredients",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Instructions",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            SingleChildScrollView(
                                child: Wrap(children: [
                              Text(
                                ingredientsFinal('original'),
                                style: TextStyle(fontSize: 20),
                              )
                            ])),
                            SingleChildScrollView(
                                child: Wrap(children: [
                              Text(
                                removeAllHtmlTags(instructionFinal()),
                                style: TextStyle(fontSize: 20),
                              )
                            ]))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBackground(String url) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fitHeight,
        ),
      ),
      // child: Image.network(url),
      margin: EdgeInsets.all(20),
    );
  }
}
