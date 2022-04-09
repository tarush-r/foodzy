import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/authentication_provider.dart';
import 'package:kjsce_hack_2022/providers/dashboard_provider.dart';
import 'package:kjsce_hack_2022/providers/food_scanner_provider.dart';
import 'package:kjsce_hack_2022/screens/login_screen.dart';
import 'package:kjsce_hack_2022/screens/splash_screen.dart';
import 'package:kjsce_hack_2022/utils/size_config.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthenticationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DashboardProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FoodScannerProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ));
  }
}
