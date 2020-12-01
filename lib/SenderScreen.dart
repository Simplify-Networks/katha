import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'RoomDetails.dart';
import 'jitsiMeet.dart';

class SenderScreen extends StatefulWidget {
  @override
  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {

  AudioCache musicCache;
  AudioPlayer instance;

  StreamSubscription <Event> updates;
  final databaseReference = FirebaseDatabase.instance.reference();

  void setListner(){
    var r = RoomDetails();

    updates = databaseReference.child("call").child(r.receiverID).onChildChanged.listen((event) {

      updates.cancel();
      if(instance != null){
        instance.pause();
      }

      if(event.snapshot.value == "accept")
      {
        FirebaseDatabase.instance.reference().child('call').child(r.receiverID).remove();

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }

        if(r.roomID != "" && r.roomID != null){
          jitsiMeet().joinMeeting("",r.roomID);
        }
        else{
          jitsiMeet().joinMeeting(r.storyTitle,"");
        }

      }
      else if(event.snapshot.value == "declined")
      {
        FirebaseDatabase.instance.reference().child('call').child(r.receiverID).remove();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
      }
    });
  }

  Future<void> playRingtone() async {
    musicCache = AudioCache(prefix: "assets/");
    instance = await musicCache.loop("dial.mp3");
  }

  @override
  void initState() {
    setListner();
    playRingtone();
    super.initState();
  }

  @override
  void dispose() {
    updates.cancel();
    if(instance != null){
      instance.pause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var r = RoomDetails();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: new Container(
        height: height,
        width: width,
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
                    //backgroundImage: NetworkImage("https://e7.pngegg.com/pngimages/145/522/png-clipart-end-call-button-telephone-call-button-computer-icons-button-text-trademark.png"),
                    backgroundImage: AssetImage("lib/assets/images/end_call_btn.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    updates.cancel();
                    if(instance != null){
                      instance.pause();
                    }

                    FirebaseDatabase.instance.reference().child('call').child(r.receiverID).remove();
                    r.clearDetails();

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
