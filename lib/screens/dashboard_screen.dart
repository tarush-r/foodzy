import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/screens/recipe_detail_screen.dart';

class DashboardScreen extends StatefulWidget {

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.0),
      child: RecipeDetailScreen("324694"),
      
    );
  }
}