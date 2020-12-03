import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:katha/UserModel.dart';
import 'package:katha/createaccount.dart';
import 'package:toast/toast.dart';

import 'DisplayUserList.dart';
import 'GlobalStorage.dart';

import 'package:http/http.dart' as http;

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  
  List newsTitle = ["Ayca Kohreman","Emre Can","Steve Jobs","Orhan Turk","Orhan Turk"];
  List newsDescription = ["Snow White starw at 15:00 today","Titanic is coming Wednesday","The Robin Hood start at 2:45.I am waiting for everyone","At 13:45, calling all Heroes to join.","On Saturday, let's dance Baby Sharks!"];
  List<DisplayUserList> RequestorList = new List<DisplayUserList>();
  List<DisplayUserList> FriendList = new List<DisplayUserList>();

  List<String> _userID = List<String>();
  List<String> _picPath = List<String>();
  List<String> _name = List<String>();
  List<String> _status = List<String>();

  List<String> _FrienduserID = List<String>();
  List<String> _FriendpicPath = List<String>();
  List<String> _Friendname = List<String>();
  UserModel userModel = new UserModel();
  StreamSubscription <Event> updates;
  final databaseReference = FirebaseDatabase.instance.reference();

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
          _FrienduserID.add(list[i]["userID"]);
          _Friendname.add(list[i]["userName"]);
          _FriendpicPath.add(list[i]["profilepicURL"]);
        }
      });
      setState(() {
        assignVariable1();
      });
    });
  }

  Future<bool> addFriend(final String userid,final String requestorID) async{

    final url = "http://35.198.227.22/addFriend"; // production server
    Map body = {"myUserID": userid,"friendUserID": requestorID};
    var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    Map<String,dynamic> map = jsonDecode(response.body.toString());
    String s = map['status'];

    if(s != "success")
    {
      return false;
    }
    else{
      return true;
    }
  }

  Future<bool> deleteFriend(final String userid,final String requestorID) async{

    final url = "http://35.198.227.22/deleteFriend"; // production server
    Map body = {"myUserID": userid,"friendUserID": requestorID};
    var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    Map<String,dynamic> map = jsonDecode(response.body.toString());
    String s = map['status'];
    print("response = $response");
    if(s != "success")
    {
      return false;
    }
    else{
      return true;
    }
  }

  void assignVariable()
  {
    RequestorList.clear();
    for(var i=0;i<_userID.length;i++){
      DisplayUserList requestor = new DisplayUserList();
      requestor.profilePicPath = _picPath[i];
      requestor.userid = _userID[i];
      requestor.name = _name[i];
      requestor.status = _status[i];
      RequestorList.add(requestor);
    }
  }

  void assignVariable1()
  {
    FriendList.clear();
    for(var i=0;i<_FrienduserID.length;i++){
      DisplayUserList friend = new DisplayUserList();
      friend.profilePicPath = _FriendpicPath[i];
      friend.userid = _FrienduserID[i];
      friend.name = _Friendname[i];
      FriendList.add(friend);
    }
  }

  Future<void> getFriendRequestList() async {
    //userModel = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value) async {
      userModel = value;
      _picPath.clear();
      _userID.clear();
      _name.clear();
      _status.clear();

      await FirebaseDatabase.instance.reference().child("friend_request").child(userModel.userID).once().then((DataSnapshot snapshot) {
        Map<dynamic,dynamic> map = snapshot.value;

        if(map !=  null)
        {
          map.forEach((key, value) {
            Map<dynamic,dynamic> map1 = value;
            map1.forEach((key, value) {
              if(key == "picPath")
              {
                _picPath.add(value);
              }
              else if(key == "requestor_id")
              {
                _userID.add(value);
              }
              else if(key == "name")
              {
                _name.add(value);
              }
              else if(key == "status")
              {
                _status.add(value);
              }
            });
          });
        }
        setState(() {
          assignVariable();
        });
      });
    });
  }

  Future<String> showAlertDialog(BuildContext context, String profilePicPath, String name,String requestorID) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    Widget rejectButton = FlatButton(
      child: Text("Reject"),
      onPressed:  () {
        FirebaseDatabase.instance.reference().child("friend_request").child(userModel.userID).child(requestorID).remove();
        Navigator.of(context).pop();
        getFriendRequestList();
        Toast.show("Rejected.", context, duration: 3);
      },
    );

    Widget acceptButton = FlatButton(
      child: Text("Accept"),
      onPressed:  () {
        addFriend(userModel.userID,requestorID).then((value){
          FirebaseDatabase.instance.reference().child("friend_request").child(userModel.userID).child(requestorID).remove();
          Navigator.of(context).pop();
          getFriendRequestList();
          getFriend();
          Toast.show("Accepted.", context, duration: 3);
        });
      },
    );

    // set up the AlertDialo
    AlertDialog alert = AlertDialog(
      title: Text("Friend Request"),
      content: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profilePicPath),
            ),
            SizedBox(
              height: 10,
            ),
            Text(name),
          ],
        ),
      ),
      actions: [
        cancelButton,
        rejectButton,
        acceptButton,
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> showFriendDialog(BuildContext context, String profilePicPath, String name,String requestorID) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    Widget DeleteButton = FlatButton(
      child: Text("Remove"),
      onPressed:  () {
        deleteFriend(userModel.userID,requestorID).then((value) {
          if(value){
            FirebaseDatabase.instance.reference().child("friend_request").child(userModel.userID).child(requestorID).remove();
            getFriend();
            Navigator.of(context).pop();
            Toast.show("Removed successfully.", context, duration: 3);
          }
          else{
            Toast.show("Fail to remove.", context, duration: 3);
          }

        });
      },
    );


    // set up the AlertDialo
    AlertDialog alert = AlertDialog(
      title: Text("Friend"),
      content: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profilePicPath),
            ),
            SizedBox(
              height: 10,
            ),
            Text(name),
          ],
        ),
      ),
      actions: [
        cancelButton,
        DeleteButton,
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*void ListenRemoverList(){
    updates = databaseReference.child("friend_request").child(userModel.userID).onChildRemoved.listen((event) {
      print("event ="+event.toString());
      print("event.snapshot ="+event.snapshot.toString());

    });
  }*/


  @override
  void initState() {
    // TODO: implement initState
    getFriendRequestList();
    //ListenRemoverList();
    getFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          DefaultTabController(length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    //new Tab(text: 'In', icon: Icon(Icons.directions_car, color: Colors.grey),),
                    //new Tab(icon: new Image.asset("lib/assets/images/end_call_btn.png"), text: "Browse"),
                    //new Tab(icon: Icon(Icons.directions_car, color: Colors.grey), text: "Browse"),
                    new Tab(text: "Family List"),
                    new Tab(text: "Family Request"),
                  ],),
                flexibleSpace: Container(
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:50.0),
                          child: Text(
                            "Family",
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
                    ],
                  ),
                ),
                //elevation: 0.0,
                toolbarHeight: 160,
              ),
              body: TabBarView(
                children: <Widget>[
                  /*ListView.builder(
                    itemCount: FriendList.length,
                    //itemBuilder: (context,i)=>ListTile(title:Text("test")),
                    itemBuilder: (context,i)=>
                        Container(
                          child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              margin: EdgeInsets.all(15.0),
                              //elevation: 10.0,
                              child:Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                      (FriendList[i].profilePicPath == "" || FriendList[i].profilePicPath == "null")?
                                      AssetImage("lib/assets/images/kathalogo.png"):
                                      NetworkImage(FriendList[i].profilePicPath),
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 130,top: 40),
                                    child: ListTile(
                                      title: Text(
                                        FriendList[i].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          fontFamily: 'Helvetica',
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print("onTap??");
                              showFriendDialog(context,RequestorList[i].profilePicPath,RequestorList[i].name,RequestorList[i].userid);
                            },
                          ),
                        ),
                  ),*/
                  Container(
                    //padding: EdgeInsets.all(5),
                    child: ListView.builder(
                      padding: EdgeInsets.all(6),
                      itemBuilder: (context,i){
                        return  Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: 130,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0,1.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10,top:15),
                                          child: CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: NetworkImage(FriendList[i].profilePicPath),
                                            backgroundColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(130,60,0,0),
                                        child: Text(FriendList[i].name, style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            color: Color(0xff4A4A4A),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      ),
                                    ],
                                  ),
                                  onTap:(){
                                    showFriendDialog(context,FriendList[i].profilePicPath,FriendList[i].name,FriendList[i].userid);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      },
                      itemCount: FriendList.length,
                    ),
                  ),
                  Container(
                    //padding: EdgeInsets.all(5),
                    child: ListView.builder(
                      padding: EdgeInsets.all(6),
                      itemBuilder: (context,i){
                        return  Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: 130,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0,1.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10,top:15),
                                          child: CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: NetworkImage(RequestorList[i].profilePicPath),
                                            backgroundColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(130,60,0,0),
                                        child: Text(RequestorList[i].name, style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            color: Color(0xff4A4A4A),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      ),
                                      /*Padding(
                                        padding: EdgeInsets.fromLTRB(size.width-140,50,0,0),
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: NetworkImage("https://www.pinclipart.com/picdir/big/89-895685_e-mail-wrong-flat-icon-clipart.png"),
                                          backgroundColor: Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(size.width-80,50,0,0),
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: NetworkImage("https://cdn3.iconfinder.com/data/icons/flat-actions-icons-9/792/Tick_Mark_Dark-512.png"),
                                          backgroundColor: Colors.black,
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  onTap:(){
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => StoryIntro(storyTitle: storytittle[i])));
                                    showAlertDialog(context,RequestorList[i].profilePicPath,RequestorList[i].name,RequestorList[i].userid);

                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      },
                      itemCount: RequestorList.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class FriendRequest extends StatelessWidget {
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
