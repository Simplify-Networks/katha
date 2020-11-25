import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/main.dart';

import 'ReceiverScreen.dart';
import 'UserModel.dart';
import 'login.dart';

void main(){
  runApp(MaterialApp(home:Splash()));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      print("Firebase initialized successfully");
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      print("Firebase fail to initialize");
    }
  }

  void getUserInfo() async
  {
    UserModel userModel = await GlobalStorage().getUser();

    if(userModel != null)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }


  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
    getUserInfo();
    /*Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
    );*/

    //Timer(Duration(milliseconds: 1500),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /*body: Center(
        child: FlutterLogo(
          size: 250,
        ),
      ),*/

      body: new Container(
        height: size.height,
        width: double.infinity,
        child: Center(
          child: FlutterLogo(
            size: 250,
          ),
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
      ),
    );
  }
}
