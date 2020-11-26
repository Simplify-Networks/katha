import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:katha/UserModel.dart';
import 'package:katha/splash.dart';
import 'GlobalStorage.dart';
import 'ReceiverScreen.dart';
import 'fragment1.dart';
import 'fragment2.dart';
import 'jitsiMeet.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
      MaterialApp(
          navigatorKey: navKey,
          home:Splash(),
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController = PageController();
  List<Widget> _screens;
  int _currentIndex = 0;

  StreamSubscription <Event> updates;
  final databaseReference = FirebaseDatabase.instance.reference();
  UserModel userM = new UserModel();

  Future<void> startDBListener() async {
    userM = await GlobalStorage().getUser();
    UserModel sD = new UserModel();
    String userid = userM.userID;
    updates = databaseReference.child("call").child(userid).onChildAdded.listen((event) {

      if(event.snapshot.key == "name"){
        sD.name = event.snapshot.value;
      }

      if(event.snapshot.key == "imagePath"){
        sD.profilePicPath = event.snapshot.value;
      }

      if(event.snapshot.key == "picPath"){
        sD.profilePicPath = event.snapshot.value;
      }

      if(event.snapshot.key == "roomID")
      {
        if(event.snapshot.value != null && event.snapshot.value != "")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiverScreen(storyTitle:"",roomID:event.snapshot.value,senderDetails:sD)));
        }
      }
      if(event.snapshot.key == "title")
      {
        if(event.snapshot.value != null && event.snapshot.value != "")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiverScreen(storyTitle:event.snapshot.value,roomID:"",senderDetails:sD)));
        }
      }
    });
  }

  @override
  void initState() {
    jitsiMeet().StartJetsiListener();
    startDBListener();
    super.initState();
  }

  @override
  void dispose() {
    jitsiMeet().stopJetsiListerner();
    databaseReference.child('call').child(userM.userID).remove();
    updates.cancel();
    super.dispose();
  }
  void _onPageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex)
  {
    _pageController.jumpToPage(selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    _screens = [Fragment1(),Fragment2(storyTitle: ""),Fragment3(),Fragment4()];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book,),
            title: Text("Story"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Contacts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Account"),
          ),
        ],
        //selectedLabelStyle: TextStyle(fontSize: 22),
        //selectedItemColor: Colors.red,
        //backgroundColor: Colors.black,
        currentIndex: this._currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

}

class Fragment3 extends StatefulWidget {
  @override
  _Fragment3State createState() => _Fragment3State();
}

class _Fragment3State extends State<Fragment3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container();
    /*return Scaffold(
      body: Column(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,65,0,0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,80,0,0),
                  child: Column(
                    children: <Widget>[
                      Text("Neil Sullivan Paul", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,115,0,0),
                  child: Column(
                    children: <Widget>[
                      Text("Protorix", style: TextStyle(
                        color: Colors.white60,
                        fontSize:30,
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            height: 100,
            width: 400,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    'Story Title',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Story description',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 400,
            width: 800,
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 500,
                    width: 500,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/
  }
}

class Fragment4 extends StatefulWidget {
  @override
  _Fragment4State createState() => _Fragment4State();
}

class _Fragment4State extends State<Fragment4> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


