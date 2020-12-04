
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/RoomDetails.dart';
import 'package:katha/UserModel.dart';
import 'package:toast/toast.dart';
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
  List<String> _FrienduserID = List<String>();
  List<String> _FriendpicPath = List<String>();
  List<String> _Friendname = List<String>();
  List<DisplayUserList> FriendList = new List<DisplayUserList>();
  List<DisplayUserList> UserDetailsList = new List<DisplayUserList>();
  List<DisplayUserList> UserDetailsListDisplay = new List<DisplayUserList>();
  StreamSubscription <Event> updates;
  TextEditingController customController = TextEditingController();

   Future<bool> checkUserID(final String userid) async{
    final url = "http://35.198.227.22/getUser"; // production server
    Map body = {"userID": userid};
    var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    // print("Response: " + response.body);
    var extractdata = json.decode(response.body);
    List data;
    data = extractdata["result"];

    if(data.length == 0)
    {
      return false;
    }
    else{
      return true;
    }
  }

  Future<bool> getFriend() async{
    //userModel = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value) async {
      userModel = value;
      _FrienduserID.clear();
      _Friendname.clear();
      _FriendpicPath.clear();

      final url = "http://35.198.227.22/getFriend"; // production server
      Map body = {"myUserID": userModel.userID};
      var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
      //print("Response: " + response.body);
      Map<String,dynamic> map = jsonDecode(response.body.toString());
      map.forEach((key, value) {
        List<dynamic> list = value;
        for(var i=0;i<list.length;i++){
//        _FrienduserID.add(list[i]["userID"]);
//        _Friendname.add(list[i]["userName"]);
//        _FriendpicPath.add(list[i]["profilepicURL"]);
//        _notesForDisplay.add(list[i]["userName"]);
          _notes.add(list[i]["userName"]);
          _notesForDisplay.add(list[i]["userName"]);
          _userID.add(list[i]["userID"]);
          _picPath.add(list[i]["profilepicURL"]);
          _status.add("-");
        }
      });

      setState(() {
        assignVariable1();
      });

    });

  }

  void assignVariable1()
  {
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

  Future<String> showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Add"),
      onPressed:  () async {

        if(userModel.userID == "" || userModel.userID == null)
        {
          Toast.show("Something went wrong. Please try again later.", context, duration: 3);
          Navigator.of(context).pop();
        }
        else{
          if(customController.text.toString().isEmpty)
          {
            Toast.show("Please enter user ID.", context, duration: 3);
            Navigator.of(context).pop();
          }
          else
          {
            if(customController.text.toString() != userModel.userID)
            {
              var isFriend = false;
              for(var i=0;i<UserDetailsList.length;i++){
                if(customController.text.toString() == UserDetailsList[i].userid){
                  isFriend = true;
                  break;
                }
              }

              if(!isFriend){
                bool exist = await checkUserID(customController.text.toString());
                if(exist){
                  databaseReference.child("friend_request").child(customController.text.toString()).child(userModel.userID).set({
                    'requestor_id': userModel.userID,
                    'name':userModel.name,
                    'picPath':userModel.profilePicPath,
                    'status':'request',
                  });
                  Toast.show("Request sent.", context, duration: 3);
                }
                else{
                  Toast.show("User ID not found.", context, duration: 3);
                }
              }
              else{
                Toast.show("User ID added.", context, duration: 3);
              }
            }
            else
            {
              Toast.show("Invalid User ID.", context, duration: 3);
            }
            Navigator.of(context).pop(customController.text.toString());
          }
        }

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invite a Member"),
      content: TextField(
        controller: customController,
        //decoration: new InputDecoration.collapsed(hintText: "Insert User ID"),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: "Enter Katha ID",
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
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
      //checkfordisplayusername();
      getFriend();
    });
  }

  Future checkUsername() async{
    final url = "http://35.198.227.22/getUsername"; // production server
    Map body = {};
    var body_encoded = json.encode(body);
    var response = await http.post(url, body: body_encoded, headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    //print("Response: " + response.body);
    var extractdata = json.decode(response.body);
    List data;
    data = extractdata["result"];
    return data;
  }

  Future<void> checkfordisplayusername() async {
    //userModel = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value) async {
      userModel = value;
      List list = await checkUsername();
      setState(() {
        assignVariable(list);
      });
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

  Color getColor(String word) {
    if(word == "-"){
      return Color.fromARGB(255, 170, 105, 181);
    }
    else if(word == "IN SESSION"){
      return Colors.red;
    }
    else if(word == "ONLINE"){
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {

    double safearea = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    String roomID = "";
    
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              height: 220.0,
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
                Positioned(child: Image.asset("lib/assets/images/applogo.png",
                    height: 115),
                    top: 1 + safearea,
                    left: 5.0,
                ),
                Positioned(child: Image.asset("lib/assets/images/logoreverse.png",
                    height: 80),
                  top: 0 + safearea,
                  right: 5.0,
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:70.0),
                        child: Text(
                          "FAMILY",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontFamily: 'Capriola',
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,60,10,0),
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
            padding: const EdgeInsets.only(top: 220),
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
                          padding: const EdgeInsets.fromLTRB(100,45,0,0),
                          child: Column(
                            children: <Widget>[
                              //Text(_notesForDisplay[(i-1) < 0 ? 0 : i], style: TextStyle(
                              Text(UserDetailsListDisplay[(i-1) < 0 ? 0 : i].name, style: TextStyle(
                                  fontFamily: 'Capriola',
                                  color: Color(0xff4A4A4A),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                        /*Padding(
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
                        ),*/
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,70,0,0),
                          child: Column(
                            children: <Widget>[
                              Text(UserDetailsListDisplay[i].status == "-" ? "OFFLINE" : UserDetailsListDisplay[i].status, style: TextStyle(
                                  fontFamily: 'Capriola',
                                  //color: UserDetailsListDisplay[i].status == "-" ? Colors.red:Color(0xff51B549),
                                  color: getColor(UserDetailsListDisplay[i].status),
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

                      if(UserDetailsListDisplay[i].status == "ONLINE")
                      {
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
                      }

                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          /*showAlertDialog(context).then((value){

          });*/
          showAlertDialog(context);
        },
        backgroundColor: Color(0xff78A2CC),
        child: Icon(Icons.add),
        //backgroundColor: Colors.lightBlue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

