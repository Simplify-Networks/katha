
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/RoomDetails.dart';
import 'package:katha/UserModel.dart';
import 'package:katha/login.dart';
import 'DisplayUserList.dart';
import 'SenderScreen.dart';

import 'package:http/http.dart' as http;

String getusername;

class Fragment2 extends StatefulWidget {
  final String storyTitle;
  const Fragment2 ({ Key key, this.storyTitle }): super(key: key);
  //final FirebaseApp app;

  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Fragment2> {

  final databaseReference = FirebaseDatabase.instance.reference();
  UserModel userModel = new UserModel();

  List<String> _notes = List<String>();
  List<String> _notesForDisplay = List<String>();

  List<String> _userID = List<String>();
  List<String> _picPath = List<String>();
  List<String> _status = List<String>();
  List<String> _id = List<String>();
  List<String> _statusFromDb = List<String>();

  List<DisplayUserList> UserDetailsList = new List<DisplayUserList>();
  List<DisplayUserList> UserDetailsListDisplay = new List<DisplayUserList>();

  StreamSubscription <Event> updates;

  void assignVariable(List name) {

    for (var i = 0; i < name.length; i++) {
      if(name[i]["userID"] != userModel.userID)
      {
        _notes.add(name[i]["userName"]);
        _notesForDisplay.add(name[i]["userName"]);
        _userID.add(name[i]["userID"]);
        _picPath.add(name[i]["profilepicURL"]);
        _status.add("-");
      }
    }

    for (var i = 0; i < _id.length; i++) {
      for (var j = 0; j < _userID.length; j++) {
        if(_id[i] == _userID[j])
        {
          _status[j] = _statusFromDb[i];
        }
      }
    }

    for(var i = 0;i<_notesForDisplay.length;i++)
    {
      DisplayUserList displayUserList = new DisplayUserList();
      displayUserList.name = _notes[i];
      displayUserList.userid = _userID[i];
      displayUserList.profilePicPath = _picPath[i];
      displayUserList.status = _status[i];

      UserDetailsList.add(displayUserList);
      UserDetailsListDisplay.add(displayUserList);
    }

  }

  Future<void> getUserStatus() async {
    await databaseReference.child("user").once().then((DataSnapshot snapshot) {
      Map<dynamic,dynamic> map = snapshot.value;
      map.forEach((key, value) {
        Map<dynamic,dynamic> map1 = value;
        map1.forEach((key, value) {
          if(key.toString() == "id")
          {
            _id.add(value.toString());
          }
          else if(key.toString() == "status")
          {
            _statusFromDb.add(value.toString());
          }
        });
      });
      checkfordisplayusername();
    });
  }

  Future checkUsername() async{
    final url = "http://35.198.227.22/getUsername"; // production server
    Map body = {};
    var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    //print("Response: " + response.body);
    var extractdata = json.decode(response.body);
    List data;
    data = extractdata["result"];
    return data;
  }

  Future<void> checkfordisplayusername() async {
    List list = await checkUsername();
    userModel = await GlobalStorage().getUser();
    setState(() {
      assignVariable(list);
    });
  }

  @override
  void initState() {
    // checkUsername();
    // assignVariable();
    getUserStatus();
    super.initState();
  }

  @override
  void dispose() {
    //databaseReference.child('call').child('userid').remove();
    UserDetailsList = null;
    UserDetailsListDisplay = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double heigh = size.height;
    double width = size.width;
    String roomID = "";
    
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              height: 200.0,
            ),
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
              overflow: Overflow.visible,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:60.0),
                        child: Text(
                          "CONTACTS",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontFamily: 'Helvetica',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,50,10,0),
                        child:Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white24,
                          ),
                          height: 40,
                          child: Theme(
                            child: TextField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: '',
                                prefixIcon: IconTheme(
                                  data: new IconThemeData(color: Colors.white),
                                  child: new Icon(Icons.search),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0),
                                ),
                              ),
                              onChanged: (text){
                                text = text.toLowerCase();
                                setState(() {
                                  if(text == "")
                                  {
                                    UserDetailsListDisplay = UserDetailsList;
                                  }
                                  else
                                  {
                                    UserDetailsListDisplay = null;
                                    UserDetailsListDisplay = new List<DisplayUserList>();

                                    UserDetailsList.forEach((userDetail) {
                                      if (userDetail.name.toLowerCase().contains(text)) {
                                        UserDetailsListDisplay.add(userDetail);
                                      }
                                    });
                                  }
                                });
                              },
                            ),
                            data: Theme.of(context).copyWith(primaryColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              //itemCount: _notesForDisplay.length,
              //itemCount: UserDetailsList.length,
              itemCount: UserDetailsListDisplay.length,
              itemBuilder: (context,i){
                return Container(
                  constraints: BoxConstraints.expand(
                    height: 120.0,
                  ),
                  child: InkWell(
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,0,0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(UserDetailsListDisplay[i].profilePicPath),
                                backgroundColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,20,0,0),
                          child: Column(
                            children: <Widget>[
                              //Text(_notesForDisplay[(i-1) < 0 ? 0 : i], style: TextStyle(
                              Text(UserDetailsListDisplay[(i-1) < 0 ? 0 : i].name, style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: Color(0xff4A4A4A),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,45,0,0),
                          child: Column(
                            children: <Widget>[
                              Text("Senior Storyteller", style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: Color(0xff4A4A4A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,75,0,0),
                          child: Column(
                            children: <Widget>[
                              Text(UserDetailsListDisplay[i].status == "-" ? "OFFLINE" : UserDetailsListDisplay[i].status, style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: UserDetailsListDisplay[i].status == "-" ? Colors.red:Color(0xff51B549),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,95,10,0),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width-50,45,0,0),
                          child: Icon(
                              Icons.call
                          ),
                        ),
                      ],
                    ),
                    onTap:(){
                      //_joinMeeting(widget.storyTitle);
                      //debugPrint('Inside = '+_notesForDisplay[i]);

                      /*databaseReference.child("flutterDevsTeam1").set({
                        'name': _notesForDisplay[i],
                        'title': widget.storyTitle
                      });*/

                      var r = RoomDetails();

                      if(widget.storyTitle == "")
                      {
                        const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                        Random _rnd = Random();
                        String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
                        roomID = getRandomString(15);
                        //jitsiMeet().joinMeeting("",roomID);

                        r.roomID = roomID;
                        r.receiverName = UserDetailsListDisplay[i].name;
                      }
                      else
                      {
                        r.storyTitle = widget.storyTitle;
                        r.receiverName = UserDetailsListDisplay[i].name;
                        //jitsiMeet().joinMeeting(widget.storyTitle,"");
                      }

                      r.receiverID = UserDetailsListDisplay[i].userid;
                      r.status = "dialling";


                      databaseReference.child("call").child(UserDetailsListDisplay[i].userid).set({
                        'name': userModel.name,
                        'title': widget.storyTitle,
                        'status':'dialling',
                        'roomID': roomID,
                        'picPath': userModel.profilePicPath,
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (context) => SenderScreen()));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

