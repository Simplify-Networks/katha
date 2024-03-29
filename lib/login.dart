import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:katha/loginwithemail.dart';
import 'package:katha/main.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'GlobalStorage.dart';
import 'UserModel.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
String appleName, appleEmail;
bool isLogin = false;
String email, userID, userType, userName;
bool isAppleLogin = false;
String profilePicPath;
Uint8List profilePicByte;
String userProfilePic = "";
String getusername;
String uid;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    isFirebaseAuthSignedIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [
            Color(0xffBFD4DB),
            Color(0xff78A2CC)
          ],
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
      padding: const EdgeInsets.fromLTRB(16, 230, 16, 0),
      child:  Image.asset('lib/assets/images/kathahigh.png'),
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
            fontFamily: "Capriola",
            fontSize: 15.0,
            color: Colors.white,
            fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h =size.height - 250;
    return Container(
      padding: EdgeInsets.fromLTRB(25, h-400, 25, 0),
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
          signInWithApple();
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
          "Login with your Email",
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

///Sign in With Google
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

///Sign in With Facebook
signInWithFacebook() async {
  // await platform.invokeMethod('signOutAGConnectAuth');
  try {
    // by default the login method has the next permissions ['email','public_profile']
    AccessToken accessToken = await FacebookAuth.instance.login();
    var facebookUserInfo = await FacebookAuth.instance.getUserData();
    print(accessToken.token);

      // Create a credential fthe access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(accessToken.token);

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential);

  } on FacebookAuthException catch (e) {
    print(e.message);
    switch (e.errorCode) {
      case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
        print("You have a previous login operation in progress");
        break;
      case FacebookAuthErrorCode.CANCELLED:
        print("login cancelled");
        break;
      case FacebookAuthErrorCode.FAILED:
        print("login failed");
        break;
    }
  }
}

///Sign in with Apple
String _createNonce(int length) {
  final random = Random();
  final charCodes = List<int>.generate(length, (_) {
    int codeUnit;

    switch (random.nextInt(3)) {
      case 0:
        codeUnit = random.nextInt(10) + 48;
        break;
      case 1:
        codeUnit = random.nextInt(26) + 65;
        break;
      case 2:
        codeUnit = random.nextInt(26) + 97;
        break;
    }

    return codeUnit;
  });

  return String.fromCharCodes(charCodes);
}

Future<OAuthCredential> _createAppleOAuthCred() async {
  final nonce = _createNonce(32);
  final nativeAppleCred = Platform.isIOS
      ? await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: sha256.convert(utf8.encode(nonce)).toString(),
  )
      : await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    webAuthenticationOptions: WebAuthenticationOptions(
      redirectUri: Uri.parse(
          'https://katha-app-aee4a.firebaseapp.com/__/auth/handler'),
      clientId: 'com.simplify.katha',
    ),
    nonce: sha256.convert(utf8.encode(nonce)).toString(),
  );
  print("nativeAppleCred: " + nativeAppleCred.toString());
  print("nativeAppleCred Email: " + nativeAppleCred.email.toString());
  appleName = nativeAppleCred.givenName + " " + nativeAppleCred.familyName;
  appleEmail = nativeAppleCred.email;
  isAppleLogin = true;
  return new OAuthCredential(
    providerId: "apple.com", // MUST be "apple.com"
    signInMethod: "oauth",   // MUST be "oauth"
    accessToken: nativeAppleCred.identityToken, // propagate Apple ID token to BOTH accessToken and idToken parameters
    idToken: nativeAppleCred.identityToken,
    rawNonce: nonce,
  );
}

signInWithApple() async{
  // sign in with Apple OAuth2 credential:
  final oauthCred = await _createAppleOAuthCred();
  final authResult = await _auth.signInWithCredential(oauthCred);
  final user = authResult.user;
  print("Email: " + user.providerData[0].email);
  print(user);
//    user.updateProfile(displayName: appleName);
  try {
    if(appleEmail != null){
//        user.updateEmail(appleEmail);
    } else{
//        user.updateEmail(user.providerData[0].email);
    }
  } catch (e){
    print("Error updating email");
    print(e);
  }
}

///save db
isFirebaseAuthSignedIn(BuildContext context) async{
//    await _auth.signOut();
  try {
    _auth.authStateChanges().listen((User user) async {
      if (user == null) {
          isLogin = false;
          print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print("user: " + user.toString());
        if (!isAppleLogin) {
          email = user.providerData[0].email;
          userID = user.uid;
          userType = user.providerData[0].providerId;
          userName = user.displayName;

        } else {
          if(appleEmail != null) {
            email = appleEmail;
          } else{
            email = user.email;
          }
          userID = user.uid;
          userType = user.providerData[0].providerId;
          userName = appleName;
        }

        isLogin = true;
        if(user.photoURL == null){
          userProfilePic = "";

        }else if(user.photoURL.contains("facebook")){
          userProfilePic = user.photoURL + "?height=200";
          downloadImage(userProfilePic);
        }
        else{
          userProfilePic = user.photoURL.replaceAll("s96-c", "s200-c");
          downloadImage(userProfilePic);
        }

        bool abc;
        abc = await checkUserExist(email);
        if(!abc) {
               await registerUser(email, userID, userType, userName, userProfilePic);
             }

        userName = user.displayName;

        if(userName == "" || userName == null){
            await checkUsername(email);
            userName = getusername;
        }

        UserModel userModel = new UserModel();

        await checkUserServerID(email);

        userModel.email = email;
        userModel.userID = uid;
        userModel.name = userName;
        userModel.LoginType = userType;
        userModel.profilePicPath = userProfilePic;

        GlobalStorage().setUser(userModel);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
//       signOutWithGoogle();
  } catch (error) {
    print(error);
  }
}

Future checkUsername(final String email) async{
  final url = "http://35.198.227.22/getUser"; // production server
  Map body = {"email": email};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  List data;
  data = extractdata["result"];
  getusername = data[0]["userName"];

  return getusername;
}

Future<bool> checkUserExist(final String email) async{
  final url = "http://35.198.227.22/getUser"; // production server
  Map body = {"email": email};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  List data;
  data = extractdata["result"];
  // print("data: " + data.toString());
  if(data.isEmpty){
    return false;
  }
  else{
    return true;
  }
}

Future checkUserServerID(final String email) async{
  final url = "http://35.198.227.22/getUser"; // production server
  Map body = {"email": email};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  List data;
  data = extractdata["result"];
  uid = data[0]["userID"];

  return uid;
}

Future<void> registerUser(final String email, final userID, final userType, final userName, final profilepic) async {
  final url = "http://35.198.227.22/registerUser"; // production server
  Map body = {"email": email, "serveruid": userID, "userType": userType, "userName": userName, "profilepicURL":profilepic, "password": ""};
  var response = await http.post(
    url, body: json.encode(body), headers: { "Accept": "application/json"},)
      .timeout(Duration(seconds: 30));
}

profilePicturePath() async{
  profilePicPath = join((await getTemporaryDirectory()).path,"profilePic.png");
  File file = File(profilePicPath);
  if(file.existsSync()) {
    profilePicByte = file.readAsBytesSync();
  } else{
    profilePicByte = (await rootBundle.load('Images/Default Profile Picture.png')).buffer.asUint8List();
  }
}

downloadImage(final image) async{
  final path = profilePicPath;
  //print(path);
  try {
    if (await File(path).exists()) {
      await File(path).delete();
    }
  } catch (e){

  }
  File file = new File(path);
  var response = await get(image);
  file.writeAsBytesSync(response.bodyBytes);

}




