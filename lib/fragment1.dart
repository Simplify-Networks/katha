import 'package:flutter/material.dart';
import 'package:katha/GlobalStorage.dart';
import 'UserModel.dart';
import 'fragment2.dart';

class Fragment1 extends StatefulWidget {
  @override
  _Fragment1State createState() => _Fragment1State();
}

class _Fragment1State extends State<Fragment1> {

  UserModel userModel = new UserModel();
  String name = "";
  String picPath = "";

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  Future<void> getUserInfo() async {
    userModel = await GlobalStorage().getUser();
    setState(() {
      name = userModel.name;
      picPath = userModel.profilePicPath;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
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
                        backgroundImage:
                        (picPath == "" || picPath == "null")?
                            AssetImage("lib/assets/images/kathalogo.png"):
                            NetworkImage(picPath),
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,80,0,0),
                  child: Column(
                    children: <Widget>[
                      Text(name, style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,115,0,0),
                  child: Column(
                    children: <Widget>[
                      Text("Senoir Storyteller", style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,210,10,10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-10,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0,1.0],
                          tileMode: TileMode.clamp
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                    child: Text("Ayca Khohreman", style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                    child: Text("Snow White starts at 15:00 today", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width-140, 80, 0, 0),
                    child: InkWell(
                      child: Text("Find out more ->", style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                      ),),
                      onTap: (){
                        debugPrint('Find out more');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:320.0),
            child: Container(
              //padding: EdgeInsets.all(5),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                itemBuilder: (context,i){
                  return  Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 800,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 150,
                                child: Image(image: NetworkImage('https://gamespot1.cbsistatic.com/uploads/original/1562/15626911/3573697-star%20wars.jpg'), fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(170,50,0,0),
                                child: Text('Star Wars', style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(170,80,0,0),
                                child: Text('The Rise of Skywalker'),
                              ),
                            ],
                          ),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Fragment2(storyTitle: "Star Wars")));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}