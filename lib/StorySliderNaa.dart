
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySliderNaa extends StatefulWidget {
  @override
  _StorySliderNaaState createState() => _StorySliderNaaState();
}

class _StorySliderNaaState extends State<StorySliderNaa> {

  List naa = ["lib/assets/naa/0001.jpg","lib/assets/naa/0002.jpg","lib/assets/naa/0003.jpg","lib/assets/naa/0004.jpg","lib/assets/naa/0005.jpg","lib/assets/naa/0006.jpg","lib/assets/naa/0007.jpg","lib/assets/naa/0008.jpg","lib/assets/naa/0009.jpg","lib/assets/naa/0010.jpg","lib/assets/naa/0011.jpg","lib/assets/naa/0012.jpg","lib/assets/naa/0013.jpg","lib/assets/naa/0014.jpg","lib/assets/naa/0015.jpg"];
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
              child: Text("My Best Friend", style: TextStyle(
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
                          image:AssetImage(naa[index])
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
              itemCount: naa.length,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),

        ],
      ),
    );
  }
}
