import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/dashboard_provider.dart';
import 'package:kjsce_hack_2022/widgets/random_recipe_result_container.dart';
import 'package:provider/provider.dart';
import 'package:kjsce_hack_2022/screens/recipe_detail_screen.dart';

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
      ],);}
  // Widget build(BuildContext context) {
  //   return RecipeDetailScreen("324694");
  //   return Container(
  //     padding: EdgeInsets.all(50.0),
  //     child: RecipeDetailScreen("324694"),
      
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
      return Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            // Expanded(
            //   child: dashboardProvider.loadingRandomRecipes
            //       ? Center(child: CircularProgressIndicator())
            //       : buildRandomRecipesRow(dashboardProvider),
            // )
            dashboardProvider.loadingRandomRecipes
                ? Container(
                  height: 360,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: 360,
                    child: buildRandomRecipesRow(dashboardProvider),
                  ),
          ],
        ),
      );
    });
  }
}
