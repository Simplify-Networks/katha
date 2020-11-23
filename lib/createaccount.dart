import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katha/loginwithemail.dart';


class createaccount extends StatefulWidget {
  @override
  _creataaccountState createState() => _creataaccountState();
}

class _creataaccountState extends State<createaccount> {
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
            Spacer(),
            Name(),
            EnterEmail(),
            EnterPassword(),
            SignIn(),
            signup(),
            SizedBox(
              height: 40,
            )
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

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          hintText: 'Name',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ).copyWith(isDense: true),
      ),
    );
  }
}

class EnterEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          hintText: 'Email Address',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ).copyWith(isDense: true),
      ),
    );
  }
}

class EnterPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: TextField(
        obscureText: true,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ).copyWith(isDense: true),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child:InkWell(
        child: Text(
          "Already have an Account? Login Here Here",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
        ),
        onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginWithEmail())
          );
        },
      ),
    );
  }
}