import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
          signInWithFacebook();
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
          signInWithGoogle();
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

FirebaseAuth _auth = FirebaseAuth.instance;

signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential authResult = await _auth.signInWithCredential(
        credential);
    final User user = authResult.user;
    print(user);
    // setState(() {
    //   isLogin = true;
    //   userName = user.displayName;
    //   userProfilePic = user.photoURL;
    // });
  } catch (error) {
    print(error);
  }
}

signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  switch (result.status) {
    case FacebookAuthLoginResponse.ok:
    // get the user data
    /*final userData = await FacebookAuth.instance.getUserData(fields: "name, picture.height(200)");
      setState(() {
        userProfilePic = userData["picture"]["data"]["url"].toString();
        userName = userData["name"].toString();
        isLogin = true;
      });*/
      break;
    case FacebookAuthLoginResponse.cancelled:
      print("login cancelled");
      break;
    default:
      print("login failed");
  }

  // Create a credential from the access token
  final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

  // Once signed in, return the UserCredential
  await _auth.signInWithCredential(facebookAuthCredential);
}

