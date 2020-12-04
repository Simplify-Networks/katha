
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StorySliderBusy extends StatefulWidget {
  @override
  _StorySliderBusyState createState() => _StorySliderBusyState();
}

class _StorySliderBusyState extends State<StorySliderBusy> {

  List busyants = ["lib/assets/busy/7E68CDFE01.jpeg","lib/assets/busy/7E68CDFE02.jpeg","lib/assets/busy/7E68CDFE03.jpeg","lib/assets/busy/7E68CDFE04.jpeg","lib/assets/busy/7E68CDFE05.jpeg","lib/assets/busy/7E68CDFE06.jpeg","lib/assets/busy/7E68CDFE07.jpeg","lib/assets/busy/7E68CDFE08.jpeg","lib/assets/busy/7E68CDFE09.jpeg","lib/assets/busy/7E68CDFE10.jpeg","lib/assets/busy/7E68CDFE11.jpeg","lib/assets/busy/7E68CDFE12.jpeg","lib/assets/busy/7E68CDFE13.jpeg","lib/assets/busy/7E68CDFE14.jpeg","lib/assets/busy/7E68CDFE15.jpeg","lib/assets/busy/7E68CDFE16.jpeg"];
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
              child: Text("Busy Ants", style: TextStyle(
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
                          image:AssetImage(busyants[index])
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
              itemCount: busyants.length,
              //viewportFraction: 0.8,
              //scale: 0.9,
            ),
          ),

        ],
      ),
    );
  }
}
