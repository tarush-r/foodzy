import 'package:flutter/material.dart';
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
        body: Center(
          child: buildDoneButton(
              context: context,
              title: 'Logout',
              function: () {
                authenticationProvider.signOut();
              }),
        ),
      );
    });
  }
}
