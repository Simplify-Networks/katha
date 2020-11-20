import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Logo(),
            TitleText(),
            SubTitle(),
            DividerLine(),
            if(Platform.isIOS) AppleButton(),
            if(Platform.isAndroid) FacebookButton(),
            GoogleButton(),
            LogintWithEmailText(),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*constraints: BoxConstraints.expand(
        height: 200.0,
      ),*/
      //left, top, right, bottom
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
      child: FlutterLogo(
        size: 128,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*constraints: BoxConstraints.expand(
        height: 200.0,
      ),*/
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Text(
        "Katha",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
      child: Text(
        "Inspiring stories at your fingertips",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 10.0,
            color: Colors.white,
            fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h =size.height - 200;
    return Container(
      padding: EdgeInsets.fromLTRB(25, h-300, 25, 0),
      child: Divider(
        thickness: 1.5,
        color: Colors.white,
      ),
    );
  }
}

class AppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: SignInButton(
        Buttons.Apple,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          //Implement Apple login here
        },
      ),
    );
    /*return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: Column(
        children: [
          SignInButton(
            Buttons.Apple,
            elevation: 5.0,
            onPressed: () {
            },
          ),
          SignInButton(
            Buttons.Google,
            elevation: 5.0,
            onPressed: () {
            },
          ),
        ],
      ),
    );*/
  }
}

class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SignInButton(
        Buttons.Facebook,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          //Implement Facebook login here
        },
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SignInButton(
        Buttons.Google,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          //Implement Google login here
        },
      ),
    );
  }
}

class LogintWithEmailText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child:InkWell(
        child: Text(
          "Login with your email",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
        ),
        onTap:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      ),
    );
  }
}





