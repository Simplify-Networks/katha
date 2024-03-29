
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySlider extends StatefulWidget {
  @override
  _StorySliderState createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {

  List gingerBread = ["lib/assets/gingerBreadStory/Cover.jpg","lib/assets/gingerBreadStory/Picture1.png","lib/assets/gingerBreadStory/Picture2.png","lib/assets/gingerBreadStory/Picture3.png","lib/assets/gingerBreadStory/Picture4.png","lib/assets/gingerBreadStory/Picture5.png","lib/assets/gingerBreadStory/Picture6.png","lib/assets/gingerBreadStory/Picture7.png","lib/assets/gingerBreadStory/Picture8.png","lib/assets/gingerBreadStory/Picture9.png","lib/assets/gingerBreadStory/Picture10.png","lib/assets/gingerBreadStory/Picture11.png","lib/assets/gingerBreadStory/Picture12.png"];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: Center(
              child: Text("The Gingerbread Man", style: TextStyle(
                  fontFamily: 'Capriola',
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
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.all(5),
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                /*return new Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.fill,
                );*/
                //i = index;
                return Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                           //image: AssetImage(gingerBread[index]),fit: BoxFit.fill,
                          image:AssetImage(gingerBread[index])
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top:(MediaQuery.of(context).size.height - 300)-25),
                        child: Text("Page ${index+1}",style: new TextStyle(
                            fontFamily: "Capriola",
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal
                        ),),
                      ),
                    ),
                  ],
                );
              },
              itemCount: gingerBread.length,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),

        ],
      ),
    );
  }
}
