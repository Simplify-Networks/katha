import 'dart:async';

import 'package:flutter/material.dart';
import 'package:katha/login.dart';
import 'package:katha/main.dart';

void main(){
  runApp(MaterialApp(home:Splash()));
  
}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    /*Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
    );*/

    Timer(Duration(milliseconds: 1500),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: new Container(
        height: size.height,
        width: double.infinity,
        child: FlutterLogo(
          size: 250,
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [Color.fromARGB(255, 69, 104, 220),Color.fromARGB(255, 176, 106, 179)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
      )
    );
  }
}
