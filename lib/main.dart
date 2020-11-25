
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'FirebaseDB.dart';
import 'fragment1.dart';
import 'fragment2.dart';
import 'SizeConfig.dart';
import 'jitsiMeet.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HomeScreen App',
              home: HomePage(),
            );
          },
        );
      },
    );
  }
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}*/
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [Fragment1(),Fragment2(storyTitle: ""),Fragment3(),Fragment4()];
  int _currentIndex = 0;

  @override
  void initState() {
    jitsiMeet().StartJetsiListener();
    FirebaseDB().startDBListener();
    super.initState();
  }

  @override
  void dispose() {
    jitsiMeet().stopJetsiListerner();
    FirebaseDB().stopDBListener();
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
            label: ('Story'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Account',
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
    double heigh = size.height;
    double width = size.width;
    return Scaffold(
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
                          fontSize: 3 * SizeConfig.textMultiplier,
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
                        fontSize: 1.5 * SizeConfig.textMultiplier,
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
    );
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


