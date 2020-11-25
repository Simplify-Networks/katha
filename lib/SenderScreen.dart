import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SenderScreen extends StatefulWidget {
  @override
  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: new Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text("Dialling", style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Center( //end call
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,height/1.5,0,0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage("https://e7.pngegg.com/pngimages/145/522/png-clipart-end-call-button-telephone-call-button-computer-icons-button-text-trademark.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    FirebaseDatabase.instance.reference().child('call').child('userid').remove();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
