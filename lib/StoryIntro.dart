import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'StorySlider.dart';
import 'fragment2.dart';

class StoryIntro extends StatefulWidget {
  final String storyTitle;
  const StoryIntro ({ Key key, this.storyTitle }): super(key: key);
  @override
  _StoryIntroState createState() => _StoryIntroState();

}

class _StoryIntroState extends State<StoryIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/2.5,
            width: MediaQuery.of(context).size.width,
            child: Image(image:AssetImage("lib/assets/Story/gingerbread.jpg"), fit: BoxFit.cover),
          ),
          Container(
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("The Gingerbread Man", style: TextStyle(
                      fontFamily: 'Capriola',
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(height: 15),
                  Text("Publisher: Usborne Publishing Ltd", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("Age Ranges: 3 - 9", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("Author: Lesley Sims", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("Pages: 12", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                  SizedBox(height: 30),
                  Text("Usborne Listen and Read Story Books", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: RaisedButton(
                color: Colors.green,
                child: Text("READ TOGETHER"),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Fragment2(storyTitle: widget.storyTitle)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Text("Read By Myself", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w200
                ),),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => StorySlider()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
