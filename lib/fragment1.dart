import 'package:flutter/material.dart';
import 'package:katha/GlobalStorage.dart';
import 'package:katha/StoryIntro.dart';
import 'Story.dart';
import 'UserModel.dart';
import 'fragment2.dart';

class Fragment1 extends StatefulWidget {
  @override
  _Fragment1State createState() => _Fragment1State();
}

class _Fragment1State extends State<Fragment1> with AutomaticKeepAliveClientMixin{

  UserModel userModel = new UserModel();
  String name = "";
  String picPath = "";
  List<Story> storyList = new List<Story>();
  List<Story> storyListDisplay = new List<Story>();
  List storyphoto = ["lib/assets/Story/gingerbread.jpg","lib/assets/Story/Beauty and the beast.jpg","lib/assets/Story/Cinderella.jpg","lib/assets/Story/Golden Eggs and Ham.jpg", "lib/assets/Story/Hello bunny.jpg", "lib/assets/Story/How big are your worries.png","lib/assets/Story/How to make a monster smile.jpg","lib/assets/Story/In your own back yard.jpg","lib/assets/Story/Squirrel.jpg","lib/assets/Story/Thomas.jpg","lib/assets/Story/Warrier.png"];
  List storytittle = ["The Gingerbread Man","Beauty and the beast","Cinderella","Golden Eggs and Ham","Hello bunny", "How big are your worries","How to make a monster smile","In your own backyard","Squirrel","Thomas","Warrier"];
  List storyexplaination = ["An American Fairy Tale","Story of a Beautiful Princess", "An Adventurous Tale","A Moral Story","A Bunny's Adventure","Story on a Little Bear","Fun Little Story about a Monster","Tale of Two Best Friends","Tale of Two Tails","Story of Thomas and Friends","A Brave Soldier's Tale"];

  @override
  void initState() {
    getUserInfo();
    assignStoryList();
    super.initState();
  }

  void assignStoryList() {
    for(var i = 0;i<storyphoto.length;i++){
      Story story = new Story();
      story.storyexplaination = storyexplaination[i];
      story.storytittle = storytittle[i];
      story.storyphoto = storyphoto[i];

      storyList.add(story);
      storyListDisplay.add(story);
    }
  }

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
  Widget build(BuildContext context) {
    super.build(context);

    double safearea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
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
                          "Library",
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
                                    storyListDisplay = storyList;
                                  }
                                  else
                                  {
                                    storyListDisplay = null;
                                    storyListDisplay = new List<Story>();

                                    storyList.forEach((userDetail) {
                                      if (userDetail.storytittle.toLowerCase().contains(text)) {
                                        storyListDisplay.add(userDetail);
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
          /*Container(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,75,0,0),
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
                  padding: const EdgeInsets.fromLTRB(130,100,0,0),
                  child: Column(
                    children: <Widget>[
                      Text(name, style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,125,0,0),
                  child: Column(
                    children: <Widget>[
                      Text("Senior Storyteller", style: TextStyle(
                          fontFamily: 'Helvetica',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                    child: Text("Ayca Khohreman", style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Color(0xff4A4A4A),
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                    child: Text("Snow White starts at 15:00 today", style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Color(0xff4A4A4A),
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width-140, 75, 0, 0),
                    child: InkWell(
                      child: Text("Find out more ->", style: TextStyle(
                          fontFamily: 'Helvetica',
                          color: Color(0xff3C29B1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
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
                        height: 130,
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
                                height: 130,
                                width: 130,
                                child: Image(image:AssetImage(storyphoto[i]), fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150,40,0,0),
                                child: Text(storytittle[i], style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    color: Color(0xff4A4A4A),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150,60,0,0),
                                child: Text(storyexplaination[i], style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    color: Color(0xff4A4A4A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              )],
                          ),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StoryIntro(storyTitle: storytittle[i])));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
                itemCount: 10,
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(top:230.0),
            child: Container(
              //padding: EdgeInsets.all(5),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                itemBuilder: (context,i){
                  return  Column(
                    children: <Widget>[
                      Container(
                        height: 130,
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
                                height: 130,
                                width: 130,
                                child: Image(image:AssetImage(storyListDisplay[i].storyphoto), fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150,40,0,0),
                                child: Text(storyListDisplay[i].storytittle, style: TextStyle(
                                    fontFamily: 'Capriola',
                                    color: Color(0xff4A4A4A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150,60,0,0),
                                child: Text(storyListDisplay[i].storyexplaination, style: TextStyle(
                                    fontFamily: 'Capriola',
                                    color: Color(0xff4A4A4A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                ),
                              )],
                          ),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StoryIntro(storyTitle: storyListDisplay[i].storytittle)));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
                itemCount: storyListDisplay.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}