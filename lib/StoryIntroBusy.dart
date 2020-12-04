import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StorySliderBusy.dart';
import 'StorySlider.dart';
import 'fragment2.dart';

class StoryIntroBusy extends StatefulWidget {
  final String storyTitle;
  const StoryIntroBusy ({ Key key, this.storyTitle }): super(key: key);
  @override
  _StoryIntroBusyState createState() => _StoryIntroBusyState();

}

class _StoryIntroBusyState extends State<StoryIntroBusy> {
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
            child: Image(image:AssetImage("lib/assets/Story/busyants.jpeg"), fit: BoxFit.cover),
          ),
          Container(
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Busy Ants", style: TextStyle(
                      fontFamily: 'Capriola',
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(height: 15),
                  Text("Publisher: Pratham Books", style: TextStyle(
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
                  Text("Author: Kanchan Bannerjee", style: TextStyle(
                    fontFamily: 'Capriola',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("Pages: 16", style: TextStyle(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => StorySliderBusy()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
