
import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katha/UserModel.dart';
import 'package:vibration/vibration.dart';

import 'GlobalStorage.dart';
import 'package:katha/jitsiMeet.dart';

class ReceiverScreen extends StatefulWidget {
  final String roomID;
  final String storyTitle;
  final UserModel senderDetails;

  const ReceiverScreen({ Key key, this.storyTitle , this.roomID, this.senderDetails }): super(key: key);

  @override
  _ReceiverScreenState createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {

  AudioCache musicCache;
  AudioPlayer instance;
  Timer timer;

  UserModel userModel = new UserModel();
  StreamSubscription <Event> updates;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<void> getUserInfo() async {
    //userModel = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value){
      userModel = value;
    });
  }

  void setListner(){

    updates = databaseReference.child("call").child(userModel.userID).onChildRemoved.listen((event) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    });
  }

  Future<void> playRingtone() async {
    timer=  new Timer.periodic(Duration(seconds:1), (Timer t) async => await Vibration.hasVibrator() ? Vibration.vibrate() : null);
    musicCache = AudioCache(prefix: "assets/");
    instance = await musicCache.loop("android.mp3");
  }

  @override
  void initState() {
    getUserInfo();
    setListner();
    playRingtone();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    updates.cancel();
    if(instance != null){
      instance.pause();
    }

    if(timer != null){
      timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: new Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
          //gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
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
        child: Stack(
          children:<Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom:200.0),
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: NetworkImage(widget.senderDetails.profilePicPath),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(widget.senderDetails.name, style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Center( //answer call
              child: Padding(
                padding: EdgeInsets.fromLTRB(width/2,height/1.5,0,0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 50.0,
                    //backgroundImage: NetworkImage("https://w7.pngwing.com/pngs/298/579/png-transparent-call-logo-button-interior-design-services-icon-design-designer-call-button-room-web-button-interior-design-services-thumbnail.png"),
                    backgroundImage: AssetImage("lib/assets/images/accept_call_btn.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    updates.cancel();
                    if(instance != null){
                      instance.pause();
                    }

                    if(timer != null){
                      timer.cancel();
                    }
                    FirebaseDatabase.instance.reference().child('call').child(userModel.userID).update({'status':'accept'});

                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }

                    if(widget.roomID != "" && widget.roomID != null){
                      jitsiMeet().joinMeeting("",widget.roomID);
                    }
                    else{
                      jitsiMeet().joinMeeting(widget.storyTitle,"");
                    }
                  },
                ),
              ),
            ),
            Center( //end call
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,height/1.5,width/2,0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("lib/assets/images/end_call_btn.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    //FirebaseDatabase.instance.reference().child('call').child(userModel.userID).remove();
                    updates.cancel();
                    if(instance != null){
                      instance.pause();
                    }

                    if(timer != null){
                      timer.cancel();
                    }
                    FirebaseDatabase.instance.reference().child('call').child(userModel.userID).update({'status':'declined'});
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
