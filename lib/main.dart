import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katha/StoryIntro.dart';
import 'package:katha/StorySlider.dart';
import 'package:katha/UserModel.dart';
import 'package:katha/login.dart';
import 'package:katha/splash.dart';
import 'FriendScreen.dart';
import 'GlobalStorage.dart';
import 'ReceiverScreen.dart';
import 'fragment1.dart';
import 'fragment2.dart';
import 'jitsiMeet.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
FirebaseAuth _auth = FirebaseAuth.instance;

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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{

  PageController _pageController = PageController();
  List<Widget> _screens;
  int _currentIndex = 0;

  StreamSubscription <Event> updates;
  StreamSubscription <Event> friend_event;
  final databaseReference = FirebaseDatabase.instance.reference();
  UserModel userM = new UserModel();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void initializing() async {
    androidInitializationSettings =new AndroidInitializationSettings('@mipmap/ic_launcher');
    iosInitializationSettings =new IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings =new InitializationSettings(androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  void _showNotifications(String name,String id) async {
    await notification(name,id);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
  }

  Future<void> notification(String name,String id) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        id, 'Channel title', 'channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Friend Request', "$name sent you a friend request.", notificationDetails);
  }

  Future<void> startDBListener() async {
    //userM = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value){
      userM = value;
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
      SetOnlineStatus();
    });
  }

  void SetOnlineStatus()
  {
    databaseReference.child("user").child(userM.userID).set({
      'id': userM.userID,
      'name':userM.name,
      'status':'ONLINE',
    });
  }

  Future<void> startDBFriendListener() async {
    //userM = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value){
      userM = value;
      friend_event = databaseReference.child("friend_request").child(userM.userID).onChildAdded.listen((event) {
        Map<dynamic,dynamic> map = event.snapshot.value;
        _showNotifications(map["name"],map["requestor_id"]);
      });
    });

  }

  @override
  void initState() {
    initializing();
    jitsiMeet().StartJetsiListener();
    startDBListener();
    startDBFriendListener();
    WidgetsBinding.instance.addObserver(this);
    //Future.delayed(Duration.zero, () => showAlertDialog(context));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    jitsiMeet().stopJetsiListerner();
    databaseReference.child('call').child(userM.userID).remove();
    databaseReference.child('user').child(userM.userID).remove();
    updates.cancel();
    friend_event.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed){
      SetOnlineStatus();
    }
    else if(state == AppLifecycleState.inactive){
      databaseReference.child('user').child(userM.userID).remove();
    }
    else if(state == AppLifecycleState.detached){
      databaseReference.child('user').child(userM.userID).remove();
    }
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
    //_screens = [Fragment1(),Fragment2(storyTitle: ""),Fragment3(),Fragment4()];
    _screens = [Fragment1(),Fragment2(storyTitle: ""),Fragment4()];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book,),
            title: Text("Library"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Family"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("News"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Account"),
          ),
        ],
        //selectedLabelStyle: TextStyle(fontSize: 22),
        //selectedItemColor: Colors.red,
        backgroundColor: Color(0xff78A2CC),
        currentIndex: this._currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),*/
      /*bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00D0E1), Color(0xFF00B3FA)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.8],
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {},
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.white),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text(
                "Business",
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text(
                "School",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),*/
      bottomNavigationBar: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            currentIndex: this._currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("lib/assets/images/library.png"),
                    size: 35
                ),
                title: Text("Library",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                    fontFamily: "Capriola",
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal
                ),),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("lib/assets/images/family.png"),
                    size: 35
                ),
                title: Text("Family",
                  textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontFamily: "Capriola",
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal
                  ),),
              ),
              /*BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text("News"),
              ),*/
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("lib/assets/images/account.png"),
                    size: 35
                ),
                title: Text("Account",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontFamily: "Capriola",
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class Fragment3 extends StatefulWidget {
  @override
  _Fragment3State createState() => _Fragment3State();
}

class _Fragment3State extends State<Fragment3> {

  List newsTitle = ["Ayca Kohreman","Emre Can","Steve Jobs","Orhan Turk","Orhan Turk"];
  List newsDescription = ["Snow White starw at 15:00 today","Titanic is coming Wednesday","The Robin Hood start at 2:45.I am waiting for everyone","At 13:45, calling all Heroes to join.","On Saturday, let's dance Baby Sharks!"];

  /*@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          DefaultTabController(length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: <Widget>[
                    //new Tab(text: 'In', icon: Icon(Icons.directions_car, color: Colors.grey),),
                    //new Tab(icon: new Image.asset("lib/assets/images/end_call_btn.png"), text: "Browse"),
                    //new Tab(icon: Icon(Icons.directions_car, color: Colors.grey), text: "Browse"),
                      new Tab(text: "1"),
                      new Tab(text: "2"),
                  ],),
                  flexibleSpace: Container(
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
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:50.0),
                            child: Text(
                              "NEWS",
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
                  toolbarHeight: 170,
                ),
                body: TabBarView(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: newsTitle.length,
                      //itemBuilder: (context,i)=>ListTile(title:Text("test")),
                      itemBuilder: (context,i)=>
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              margin: EdgeInsets.all(15.0),
                              //elevation: 10.0,
                              child:Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      newsTitle[i],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        fontFamily: 'Helvetica',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      newsDescription[i],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          fontFamily: 'Helvetica',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                    Center(
                      child: Text("Page 2"),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }*/

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom:55.0),
                child: Text(
                  "News",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontFamily: 'Capriola',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: ListView.builder(
              itemCount: newsTitle.length,
              //itemBuilder: (context,i)=>ListTile(title:Text("test")),
              itemBuilder: (context,i)=>
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      margin: EdgeInsets.all(15.0),
                      //elevation: 10.0,
                      child:Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              newsTitle[i],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                fontFamily: 'Capriola',
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              newsDescription[i],
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                fontFamily: 'Capriola',
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class Fragment4 extends StatefulWidget {
  @override
  _Fragment4State createState() => _Fragment4State();
}

class _Fragment4State extends State<Fragment4> {

  UserModel userModel = new UserModel();
  String name = "";
  String picPath = "";

  Future<void> getUserInfo() async {
    //userModel = await GlobalStorage().getUser();
    GlobalStorage().getUser().then((value){
      userModel = value;
      setState(() {
        name = userModel.name;
        picPath = userModel.profilePicPath;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       child: Column(
         children: <Widget>[
           Stack(
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
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.only(bottom:55.0),
                     child: Text(
                       "ACCOUNT",
                       textAlign: TextAlign.center,
                       style: new TextStyle(
                           fontFamily: 'Capriola',
                           color: Colors.white,
                           fontSize: 20,
                           fontWeight: FontWeight.w400
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.only(top:140),
                     child: CircleAvatar(
                       radius: 60.0,
                       backgroundImage:
                       (picPath == "" || picPath == null)?
                       AssetImage("lib/assets/images/kathalogo.png"):
                       NetworkImage(picPath),
                       backgroundColor: Colors.black,
                     ),
                   ),
                 ),
               ),
             ],
           ),
           Container(
             child: Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(top:10.0),
                   child: Text(name, style: TextStyle(
                       fontFamily: 'Capriola',
                       color: Colors.black,
                       fontSize: 17,
                       fontWeight: FontWeight.w600
                   ),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:10.0,bottom:10),
                   child: SelectableText("ID: ${userModel.userID}", style: TextStyle(
                       fontFamily: 'Capriola',
                       color: Colors.black,
                       fontSize: 15,
                       fontWeight: FontWeight.w700
                   ),),
                 ),
                 /*Card(
                   elevation: 0,
                   color: Colors.transparent,
                   child: ListTile(
                     title: Text("Information Update", style: TextStyle(
                         fontFamily: 'Helvetica',
                         color: Colors.black,
                         fontSize: 15,
                         fontWeight: FontWeight.w500
                     ),),
                     trailing: Icon(Icons.arrow_forward_ios),
                   ),
                 ),*/
                 InkWell(
                   child: Card(
                     elevation: 0,
                     color: Colors.transparent,
                     child: ListTile(
                       title: Text("Family", style: TextStyle(
                           fontFamily: 'Capriola',
                           color: Colors.black,
                           fontSize: 15,
                           fontWeight: FontWeight.w500
                       ),),
                       trailing: Icon(Icons.arrow_forward_ios),
                     ),
                   ),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen()));
                   },
                 ),
                 InkWell(
                   child: Card(
                     elevation: 0,
                     color: Colors.transparent,
                     child: ListTile(
                       title: Text("Sign Out", style: TextStyle(
                           fontFamily: 'Capriola',
                           color: Colors.red,
                           fontSize: 15,
                           fontWeight: FontWeight.w600
                       ),),
                     ),
                   ),
                   onTap: (){
                     signout(context);
                   },
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
    );
  }
}

signout(BuildContext context) async{
  GlobalStorage().logoff();
  await _auth.signOut();
  await GoogleSignIn().signOut();
  await FacebookAuth.instance.logOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));
}


