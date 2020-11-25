import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/jitsiMeet.dart';

import 'UserModel.dart';

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
    final userM = await GlobalStorage().getUser();
    String userid = userM.userID;
    updates = databaseReference.child("call").child(userid).onChildAdded.listen((event) {

      if(event.snapshot.key == "roomID")
      {
        print("aaa event.snapshot.key roomID = "+event.snapshot.key);
        if(event.snapshot.value != null && event.snapshot.value != "")
        {
          print("aaa Some Data changed = "+event.snapshot.value);
          jitsiMeet().joinMeeting("",event.snapshot.value);
        }
      }
      if(event.snapshot.key == "title")
      {
        print("aaa event.snapshot.key title = "+event.snapshot.key);
        if(event.snapshot.value != null && event.snapshot.value != "")
        {
          print("aaa Some Data changed = "+event.snapshot.value);
          jitsiMeet().joinMeeting(event.snapshot.value,"");
        }
      }
    });
  }

  void stopDBListener()
  {
    print('stopDBListener');
    databaseReference.child('call').child('userid').remove();
    updates.cancel();
  }
}