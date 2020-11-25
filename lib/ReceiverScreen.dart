
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class ReceiverScreen extends StatefulWidget {
  @override
  _ReceiverScreenState createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {

  @override
  void initState() {
    //FlutterRingtonePlayer.playNotification();
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: new Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp
          ),
        ),
        child: Stack(
          children:<Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom:200.0),
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text("Neil Sullivan Paul", style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Center( //answer call
              child: Padding(
                padding: EdgeInsets.fromLTRB(width/2,height/1.5,0,0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage("https://w7.pngwing.com/pngs/298/579/png-transparent-call-logo-button-interior-design-services-icon-design-designer-call-button-room-web-button-interior-design-services-thumbnail.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    debugPrint('Answer call');
                  },
                ),
              ),
            ),
            Center( //end call
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,height/1.5,width/2,0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage("https://e7.pngegg.com/pngimages/145/522/png-clipart-end-call-button-telephone-call-button-computer-icons-button-text-trademark.png"),
                    backgroundColor: Colors.black,
                  ),
                  onTap: (){
                    debugPrint('Declined call');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
