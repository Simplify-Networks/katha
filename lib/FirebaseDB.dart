import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/jitsiMeet.dart';
import 'package:get/get.dart';

import 'ReceiverScreen.dart';
import 'UserModel.dart';
import 'main.dart';

class FirebaseDB {
  static final FirebaseDB _firebaseDB = FirebaseDB._internal();

  factory FirebaseDB() {
    return _firebaseDB;
  }

  FirebaseDB._internal();

  StreamSubscription <Event> updates;
  final databaseReference = FirebaseDatabase.instance.reference();

  void startDBListener() async
  {
    //final userM = await GlobalStorage().getUser();

    GlobalStorage().getUser().then((value){
      String userid = value.userID;
      updates = databaseReference.child("call").child(userid).onChildAdded.listen((event) {

        if(event.snapshot.key == "roomID")
        {
          if(event.snapshot.value != null && event.snapshot.value != "")
          {
            //jitsiMeet().joinMeeting("",event.snapshot.value);
          }
        }
        if(event.snapshot.key == "title")
        {
          if(event.snapshot.value != null && event.snapshot.value != "")
          {
            //jitsiMeet().joinMeeting(event.snapshot.value,"");
          }
        }
      });
    });
  }

  void stopDBListener()
  {
    print('stopDBListener');
    databaseReference.child('call').child('userid').remove();
    updates.cancel();
  }
}