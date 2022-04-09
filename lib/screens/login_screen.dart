import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/authentication_provider.dart';
import 'package:kjsce_hack_2022/widgets/textfields.dart';
import 'package:provider/provider.dart';

import '../utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AuthenticationProvider>(
        builder: (ctx, authenticationProvider, child) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login_screen_background.png'),
                  fit: BoxFit.cover)),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.4)
                  ])),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: ListView(
                  reverse: true,

                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //Container(height: 100,),
                    // Center(
                    //     child: Container(
                    //   padding: EdgeInsets.all(120),
                    //   height: 250,
                    //   width: 250,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage('assets/images/logo.png'))),
                    // )),
                    SizedBox(height: 30),
                    Text('Food for your mood!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Register yourself now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'wherever you go',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 15,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),

                    SizedBox(height: 40),

//Text Field

                    Center(
                        child: customTextField(context,
                            hintText: 'Enter phone no',
                            showTitle: false, onChanged: (value) {
                      authenticationProvider.phoneNo = value;
                    })
                        // TextField(
                        //   style: TextStyle(color: Colors.white),
                        //   decoration: InputDecoration(
                        //       border: InputBorder.none,
                        //       focusedBorder: InputBorder.none,
                        //       enabledBorder: InputBorder.none,
                        //       errorBorder: InputBorder.none,
                        //       disabledBorder: InputBorder.none,
                        //       hintText: "Enter phone no",
                        //       hintStyle: TextStyle(color: Colors.white)),
                        //   onChanged: (value) {
                        //     // this.phoneNo = value;
                        //   },
                        // ),
                        ),
                    SizedBox(
                      height: 10,
                    ),
                    authenticationProvider.codeSent
                        // true
                        ? Center(
                            child: customTextField(context,
                                hintText: 'OTP',
                                showTitle: false, onChanged: (value) {
                            authenticationProvider.smsCode = value;
                          })

                            // TextField(
                            //   style: TextStyle(color: Colors.white),
                            //   decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       focusedBorder: InputBorder.none,
                            //       enabledBorder: InputBorder.none,
                            //       errorBorder: InputBorder.none,
                            //       disabledBorder: InputBorder.none,
                            //       hintText: "OTP",
                            //       hintStyle: TextStyle(color: Colors.white)),
                            //   onChanged: (value) {
                            //     // this.smsCode = value;
                            //   },
                            // ),
                            )
                        : Container(),

                    SizedBox(
                      height: 20,
                    ),

//Button
                    InkWell(
                      onTap: () {
                        authenticationProvider.codeSent
                            ? authenticationProvider.signInWithOTP()
                            : authenticationProvider.verifyPhone();
                      },
                      child: Container(
                          child: Center(
                              child: authenticationProvider.codeSent
                                  // true
                                  ? Text("Login",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))
                                  : Text("Verify",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                            //color:Colors.white
                          )),
                    ),

                    //child: codeSent ? Text("Login") : Text("Verify"),
                  ].reversed.toList(),
                ),
              )),
        ),
      );
    });
  }
}
