import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/screens/dashboard_screen.dart';
import 'package:kjsce_hack_2022/screens/food_scanner_screen.dart';
import 'package:kjsce_hack_2022/screens/ingredients_screen.dart';
import 'package:kjsce_hack_2022/screens/profile_screen.dart';

final db = FirebaseFirestore.instance;
final userRef = db.collection('user');

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  onPageChanged(pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    print('JUMPING');
    pageController.jumpToPage(
      pageIndex,
    );
  }

  Widget bottomNavigationBarItem(IconData icon, String title, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(height: 20, child: Icon(icon)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          DashboardScreen(),
          DashboardScreen(),
          FoodScannerScreen(),
          GetIngredients(),
          ProfileScreen(),
          // UserHome(),
          // MealTracker2(),
          // AllWorkoutDays(),
          // ProgressTrackerTabScreen(),
          // UserProfile(),
//                widget.mode == 'test' ? AllSettings() : null,
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.deepPurple,
        activeColor: Colors.white,
        inactiveColor: Colors.black,
        currentIndex: pageIndex,
        border: Border(
            top: BorderSide(
          color: Theme.of(context).primaryColorLight,
          width: 0.1, // One physical pixel.
        )),
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
              icon: pageIndex == 0
                  ? bottomNavigationBarItem(
                      Icons.home,
                      '',
                      Theme.of(context).buttonColor,
                    )
                  : bottomNavigationBarItem(
                      Icons.home, '', Theme.of(context).accentColor)),
          BottomNavigationBarItem(
              icon: pageIndex == 1
                  ? bottomNavigationBarItem(
                      Icons.favorite,
                      '',
                      Theme.of(context).buttonColor,
                    )
                  : bottomNavigationBarItem(
                      Icons.favorite,
                      '',
                      Theme.of(context).accentColor,
                    )),
          BottomNavigationBarItem(
              icon: pageIndex == 2
                  ? bottomNavigationBarItem(
                      Icons.camera_alt,
                      '',
                      Theme.of(context).buttonColor,
                    )
                  : bottomNavigationBarItem(
                      Icons.camera_alt,
                      '',
                      Theme.of(context).accentColor,
                    )),
          BottomNavigationBarItem(
              icon: pageIndex == 3
                  ? bottomNavigationBarItem(
                      Icons.search,
                      '',
                      Theme.of(context).buttonColor,
                    )
                  : bottomNavigationBarItem(
                      Icons.search,
                      '',
                      Theme.of(context).accentColor,
                    )),
          BottomNavigationBarItem(
              icon: pageIndex == 4
                  ? bottomNavigationBarItem(
                      Icons.person,
                      '',
                      Theme.of(context).buttonColor,
                    )
                  : bottomNavigationBarItem(
                      Icons.person,
                      '',
                      Theme.of(context).accentColor,
                    )),
        ],
      ),
    );
  }
}
