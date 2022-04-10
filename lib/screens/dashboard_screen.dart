import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/dashboard_provider.dart';
import 'package:kjsce_hack_2022/screens/joke_trivia.dart';
import 'package:kjsce_hack_2022/widgets/random_recipe_result_container.dart';
import 'package:provider/provider.dart';
import 'package:kjsce_hack_2022/screens/substitute_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    print('init State');
    Future.delayed(Duration.zero, () {
      Provider.of<DashboardProvider>(context, listen: false)
          .loadRandomRecipes();
    });
    super.initState();
  }

  buildRandomRecipesRow(DashboardProvider dashboardProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            'TRY SOMETHING NEW!',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dashboardProvider.randomRecipes.length,
            itemBuilder: (context, index) {
              return RandomRecipeResultContainer(
                  recipe: dashboardProvider.randomRecipes[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // Expanded(
                  //   child: dashboardProvider.loadingRandomRecipes
                  //       ? Center(child: CircularProgressIndicator())
                  //       : buildRandomRecipesRow(dashboardProvider),
                  // )
                  dashboardProvider.loadingRandomRecipes
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: 500,
                          child: buildRandomRecipesRow(dashboardProvider),
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SubstituteIngredients()));
                          },
                          child: Text('Substitute Ingredients')),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

      );
    });
  }
}
