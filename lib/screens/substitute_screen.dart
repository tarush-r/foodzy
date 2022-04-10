import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class SubstituteIngredients extends StatefulWidget {
  @override
  _SubstituteIngredientsState createState() => _SubstituteIngredientsState();
}

class _SubstituteIngredientsState extends State<SubstituteIngredients> {
  TextEditingController controller = TextEditingController();
  List<dynamic> substituteIngredients = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter ingredient name'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple)),
                    onPressed: () async {
                      substituteIngredients = await dashboardProvider
                          .substituteIngredients(controller.text);
                      setState(() {});
                    },
                    child: Text('Find Substitutes')),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: substituteIngredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          color: Colors.amber,
                          child: Center(
                              child: Text('${substituteIngredients[index]}')),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
