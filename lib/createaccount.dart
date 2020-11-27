import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katha/login.dart';
import 'package:katha/loginwithemail.dart';
import 'package:http/http.dart' as http;
import 'package:katha/main.dart';
import 'package:crypto/crypto.dart';
import 'GlobalStorage.dart';
import 'UserModel.dart';

String _name,_email,_password, _userid= "";
String _sessionid = "";
String usertype = "";
final _formKey = GlobalKey<FormState>();
final FirebaseAuth mAuth = FirebaseAuth.instance;
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
UserModel userModel = new UserModel();

class createaccount extends StatefulWidget {
  @override
  _creataaccountState createState() => _creataaccountState();
}

class _creataaccountState extends State<createaccount> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: new Container(
        height: double.infinity,
        width:double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Logo(),
              SubTitle(),
              SizedBox(
                height: size.height * 0.07,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Name(),
                    EnterEmail(),
                    EnterPassword(),
                  ],
                ),
              ),
              SignIn(),
              signup(),
            ],
          ),
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
      child:  Image.asset('lib/assets/images/white_logo_transparent_background 1.png'),
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
          fontFamily: "Helvetica",
          fontSize: 15.0,
          color: Colors.white,
          fontWeight: FontWeight.w400,
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
      child: TextFormField(
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
          errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ).copyWith(isDense: true),
        validator: (String value) {
          if(value.isEmpty){
            return 'Name is required.' ;
          }
          return null;
        },
        onSaved: (String value){
          _name = value;
        },
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
      child: TextFormField(
        controller: emailController,
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
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ).copyWith(isDense: true),
        validator: (String value) {
          if(value.isEmpty){
            return 'Email is required';
          }
          if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
            return 'Enter a valid email address';
          }
          // validator has to return something :)
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
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
      child: TextFormField(
        controller: passwordController,
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
        textInputAction: TextInputAction.done,
        validator: (String value) {
          if(value.isEmpty){
            return 'Password is required';
          }
          return null;
        },
        onSaved: (String value){
          _password = value;
        },
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
          signupwithemail(context);
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
          Navigator.of(context).
          popUntil((route)
          => route.isFirst);
        },
      ),
    );
  }
}

signupwithemail(BuildContext context) async{
  if(!_formKey.currentState.validate()) {
    return;
  }
  _formKey.currentState.save();

  print(_name);
  print(_password);
  print(_email);

  _sessionid = ( _name + _password + _email);

  usertype = ("Self");

  if(await checkUserExist(_email) == true){
    showAlertDialog(context);
  }else{
    await signupsuccess(_name, _email, _password, _sessionid, usertype, context);
    await linkfirebase(_email,_password);
  }
}

void linkfirebase(_email, _password) async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> checkUserExist(final String email) async{
  final url = "http://35.198.227.22/getUser"; // production server
  Map body = {"email": email};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  List data;
  data = extractdata["result"];
  print('get result');
  // print("data: " + data.toString());
  if(data.isEmpty){
    return false;
  }
  else{
    return true;
  }
}

Future<bool> signupsuccess(final String name, email, password, sessionid, usertype, BuildContext context) async{
  final url = "http://35.198.227.22/registerUser"; // production server
  Map body = {"email": email, "userID": sessionid, "userType": usertype, "userName": name, "password": password, "profilepicURL":" "};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  String data;
  data = extractdata["status"];
  // print("data: " + data.toString());
  if(data == "success"){
    showSuccessDialog(context, email, sessionid, name, usertype, '');
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Email Existing"),
    content: Text("This Email is already register"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccessDialog(BuildContext context,uemail, id, username, type, pic) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      userModel.email = uemail;
      userModel.userID = id;
      userModel.name = username;
      userModel.LoginType = type;
      userModel.profilePicPath = pic;

      GlobalStorage().setUser(userModel);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Congratulations"),
    content: Text("You had Successfully Sign Up your account. Continue to Sign In."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}