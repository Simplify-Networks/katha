
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySliderMere extends StatefulWidget {
  @override
  _StorySliderMereState createState() => _StorySliderMereState();
}

class _StorySliderMereState extends State<StorySliderMere> {

  List mere = ["lib/assets/mere/5FF1F1A601.jpeg","lib/assets/mere/5FF1F1A602.jpeg","lib/assets/mere/5FF1F1A603.jpeg","lib/assets/mere/5FF1F1A604.jpeg","lib/assets/mere/5FF1F1A605.jpeg","lib/assets/mere/5FF1F1A606.jpeg","lib/assets/mere/5FF1F1A607.jpeg","lib/assets/mere/5FF1F1A608.jpeg","lib/assets/mere/5FF1F1A609.jpeg","lib/assets/mere/5FF1F1A610.jpeg","lib/assets/mere/5FF1F1A611.jpeg","lib/assets/mere/5FF1F1A612.jpeg","lib/assets/mere/5FF1F1A613.jpeg","lib/assets/mere/5FF1F1A614.jpeg","lib/assets/mere/5FF1F1A615.jpeg"];
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
              child: Text("Under My Bed", style: TextStyle(
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
                          image:AssetImage(mere[index])
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
              itemCount: mere.length,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),

        ],
      ),
    );
  }
}
