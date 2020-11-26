
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:katha/RoomDetails.dart';
import 'package:katha/login.dart';
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

  List<String> _notes = List<String>();
  List<String> _notesForDisplay = List<String>();


  void assignVariable(List name) {
    for (var i = 0; i < name.length; i++) {
      _notes.add(name[i]["userName"]);
      _notesForDisplay.add(name[i]["userName"]);
      print(name[i]["userName"]);
    }
  }

  Future checkUsername() async{
    final url = "http://35.198.227.22/getUsername"; // production server
    Map body = {};
    var response = await http.post(url, body: json.encode(body), headers:{ "Accept": "application/json" } ,).timeout(Duration(seconds: 30));
    // print("Response: " + response.body);
    var extractdata = json.decode(response.body);
    List data;
    data = extractdata["result"];
    getusername = data[0]["userName"];
    print(data);
    return data;
  }

  checkfordisplayusername() async {
    List list = await checkUsername();
    setState(() {
      assignVariable(list);
    });
  }


  @override
  void initState() {
    // checkUsername();
    // assignVariable();
    checkfordisplayusername();
    super.initState();
  }

  @override
  void dispose() {
    //databaseReference.child('call').child('userid').remove();
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
              gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
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
                                  _notesForDisplay = _notes.where((note) {
                                    var noteTitle = note.toLowerCase();
                                    return noteTitle.contains(text);
                                  }).toList();
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
              itemCount: _notesForDisplay.length,
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
                                backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                backgroundColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,20,0,0),
                          child: Column(
                            children: <Widget>[
                              Text(_notesForDisplay[(i-1) < 0 ? 0 : i], style: TextStyle(
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
                              Text("AVAILABLE", style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: Color(0xff51B549),
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
                        r.receiverName = _notesForDisplay[i];
                      }
                      else
                      {
                        r.storyTitle = widget.storyTitle;
                        r.receiverName = _notesForDisplay[i];
                        //jitsiMeet().joinMeeting(widget.storyTitle,"");
                      }

                      databaseReference.child("call").child("userid").set({
                        'name': _notesForDisplay[i],
                        'title': widget.storyTitle,
                        'status':'dialing',
                        'roomID': roomID,
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

/*class Fragment2 extends StatefulWidget {
  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Fragment2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heigh = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(
                  height: 200.0,
                ),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
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
                            padding: const EdgeInsets.only(top:50.0),
                            child: Text(
                              "Contacts",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Search...'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 4,
                  padding: EdgeInsets.fromLTRB(15,0,15,0),
                  itemBuilder: (context,i){
                    return Container(
                      constraints: BoxConstraints.expand(
                        height: 120.0,
                      ),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,35,0,0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                  backgroundColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,40,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Neil Sullivan Paul", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 3 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,70,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Protorix", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,90,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Protorix", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,110,0,0),
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(width-80,60,0,0),
                            child: FlutterLogo(
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
