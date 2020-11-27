import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katha/createaccount.dart';
import 'package:http/http.dart' as http;
import 'package:katha/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserModel.dart';
import 'GlobalStorage.dart';

String _email,_password= "";
final _formKey = GlobalKey<FormState>();
String getpassword,getusername,getpic, getuserid, getusertype;
final FirebaseAuth mAuth = FirebaseAuth.instance;
List details ;
UserModel userModel = new UserModel();

class LoginWithEmail extends StatefulWidget {
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
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
                height: size.height * 0.15,
              ),
              Form(
                key:_formKey,
                child: Column(
                  children: [
                    EnterEmail(),
                    EnterPassword(),
                  ],
                ),
              ),
               SignIn(),
               signup(),
              SizedBox(
                height: 40,
              )
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

class EnterEmail extends StatelessWidget {
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
          signin(context);
        },
        child: Text(
          "Sign In",
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
          "Do not have an Account? Create Here",
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
              MaterialPageRoute(builder: (context) => createaccount())
          );
        },
      ),
    );
  }
}

signin(BuildContext context) async{
  String congratulation = "Congratulations";
  String success = "You had Successfully Sign In into your account.";
  String warning = "Sign In Error";
  String warninglong = "Email or Password incorrect. Please Try Again.";

  if(!_formKey.currentState.validate()) {
    return;
  }
  _formKey.currentState.save();

  print(_password);
  print(_email);

  List checkuserexsists = await checkUserExist(_email, _password);

  if(checkuserexsists[0] == true){
    signinfirebase(_email, _password);
    showdynamicDialog(congratulation, success, context, checkuserexsists[1], checkuserexsists[2],checkuserexsists[3],checkuserexsists[4],checkuserexsists[5]);

  } else {
    showdynamicDialog(warning, warninglong, context, '', '', '', '', '');
  }
}

Future<List> checkUserExist(final String email, _password) async{
  final url = "http://35.198.227.22/getUser"; // production server
  Map body = {"email": email};
  var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
  // print("Response: " + response.body);
  var extractdata = json.decode(response.body);
  List data;
  data = extractdata["result"];
  getpassword = data[0]["password"];
  getusername = data[0]["userName"];
  getpic = data[0]["profilepicURL"];
  getuserid = data[0]["userID"];
  getusertype = data[0]["userType"];
  print('abc' + getpassword);
  // print("data: " + data.toString());

  if(getpassword == _password){
    details = [true,getusername,getpic,getuserid,getusertype,email];
    return details;
  }else{
    return [false] ;
  }
}

void signinfirebase(_email, _password) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    }catch(e){
      print(e.toString());
    }
}

showdynamicDialog(text1, text2, BuildContext context, username ,pic, id, type, uemail) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      if (text1 =="Congratulations") {

        userModel.email = uemail;
        userModel.userID = id;
        userModel.name = username;
        userModel.LoginType = type;
        userModel.profilePicPath = pic;

        GlobalStorage().setUser(userModel);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

      } else if (text1 =="Sign In Error") {
        Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => LoginWithEmail()));
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(text1),
    content: Text(text2),
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