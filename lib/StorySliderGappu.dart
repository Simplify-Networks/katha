import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySliderGappu extends StatefulWidget {
  @override
  _StorySliderGappuState createState() => _StorySliderGappuState();
}

class _StorySliderGappuState extends State<StorySliderGappu> {

  List gappu = ["lib/assets/gappu/40A5125001.jpeg","lib/assets/gappu/40A5125002.jpeg","lib/assets/gappu/40A5125003.jpeg","lib/assets/gappu/40A5125004.jpeg","lib/assets/gappu/40A5125005.jpeg","lib/assets/gappu/40A5125006.jpeg","lib/assets/gappu/40A5125007.jpeg","lib/assets/gappu/40A5125008.jpeg","lib/assets/gappu/40A5125009.jpeg","lib/assets/gappu/40A5125010.jpeg","lib/assets/gappu/40A5125011.jpeg","lib/assets/gappu/40A5125012.jpeg","lib/assets/gappu/40A5125013.jpeg","lib/assets/gappu/40A5125014.jpeg","lib/assets/gappu/40A5125015.jpeg","lib/assets/gappu/40A5125016.jpeg","lib/assets/gappu/40A5125017.jpeg"];
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
              child: Text("Gappu Can't Dance", style: TextStyle(
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
                          image:AssetImage(gappu[index])
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
              itemCount: gappu.length,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),

        ],
      ),
    );
  }
}
