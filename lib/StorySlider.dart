
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySlider extends StatefulWidget {
  @override
  _StorySliderState createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {

  List gingerBread = ["lib/assets/Story/Cover.jpg","Picture1.png","lib/assets/Story/Picture2.png","lib/assets/Story/Picture3.png","lib/assets/Story/Picture4.png","lib/assets/Story/Picture5.png","lib/assets/Story/Picture6.png","lib/assets/Story/Picture7.png","lib/assets/Story/Picture8.png","lib/assets/Story/Picture9.png","lib/assets/Story/Picture10.png","lib/assets/Story/Picture11.png","lib/assets/Story/Picture12.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Center(
              child: Text("Beauty and the beast", style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  color: Color(0xff4A4A4A),
                  fontSize: 25,
                  fontWeight: FontWeight.w800
              ),),
            ),
          ),
          /*Container(
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.all(5),
            child: PageView(
              pageSnapping: true,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
              ],
            ),
          ),*/
          Container(
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.all(5),
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                /*return new Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.fill,
                );*/
                return Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 120,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/Story/Cover.jpg"),fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 10,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),
        ],
      ),
    );
  }
}
