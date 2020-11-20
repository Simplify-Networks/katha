

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: new Container(
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
