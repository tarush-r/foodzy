import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kjsce_hack_2022/providers/authentication_provider.dart';
import 'package:kjsce_hack_2022/widgets/buttons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (ctx, authenticationProvider, child) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            buildContent(),
        Column(
          children: <Widget>[
            const SizedBox(height: 20,),
            Card(
              child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),)
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),)
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.question_mark),
                  title: Text('How To Use'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),)
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  trailing: IconButton(
                    onPressed: () {
                      authenticationProvider.signOut();
                    },
                    icon: Icon(Icons.arrow_forward_ios),)
              ),
            ),
          ],
        ),
          ],
        )

        /*body: Center(
          child: buildDoneButton(
              context: context,
              title: 'Logout',
              function: () {
                authenticationProvider.signOut();
              }),
        ),*/
      );
    });
  }
  Widget buildTop() {
    return Stack(
        clipBehavior: Clip.none,
        alignment : Alignment.center,
        children: [
          coverImage(),
          Positioned(
            top: 208,
            child:  profileImage(),)
        ]
    );
  }
  Widget coverImage() => Container(
    child: Image.network(
        'https://foodtruckempire.com/wp-content/uploads/Cateringfamilydinner.jpg',
         width: double.infinity,
         height:280 ,
         fit: BoxFit.cover,),
  );
  Widget profileImage() => CircleAvatar(
    radius : 62,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage(
        'https://media.istockphoto.com/vectors/character-design-vector-id1223616306?k=20&m=1223616306&s=612x612&w=0&h=WeQZgrmUGsZtNSljxdPbw8lcR7l3yoLQMbMxguX3ajc=',
    ),
  );
  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 70,),
      Text(
        'Hey Foodie!',
        style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),
      )
    ],
  );
}
