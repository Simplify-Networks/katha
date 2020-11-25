import 'package:flutter/material.dart';
import 'SizeConfig.dart';
import 'fragment2.dart';

class Fragment1 extends StatefulWidget {
  String imgPaths1;
  String usernames1;

  Fragment1({this.imgPaths1, this.usernames1});

  @override
  _Fragment1State createState() => _Fragment1State();
}

class _Fragment1State extends State<Fragment1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8FA),
      body: Column(
        //overflow: Overflow.visible,
        children: <Widget>[
          ContainerBox(),
          Container(
            padding: EdgeInsets.all(5),
            height: 100,
            width: 400,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    'Story Title',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Story description',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:15,right: 15,top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heigh = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              height: 200.0,
            ),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
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
                  padding: const EdgeInsets.fromLTRB(20,65,0,0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        (widget.imgPaths1 == "" || widget.imgPaths1 == "null")?
                            AssetImage("lib/assets/images/kathalogo.png"):
                            NetworkImage(widget.imgPaths1),
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,80,0,0),
                  child: Column(
                    children: <Widget>[
                      Text(widget.usernames1, style: TextStyle(
                          color: Colors.white,
                          fontSize: 2.5 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130,115,0,0),
                  child: Column(
                    children: <Widget>[
                      Text("Senoir Storyteller", style: TextStyle(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold
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
                      gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
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
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                    child: Text("Snow White starts at 15:00 today", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width-140, 80, 0, 0),
                    child: InkWell(
                      child: Text("Find out more ->", style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
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
                        height: 200,
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
                                height: 200,
                                width: 150,
                                child: Image(image: NetworkImage('https://gamespot1.cbsistatic.com/uploads/original/1562/15626911/3573697-star%20wars.jpg'), fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(170,50,0,0),
                                child: Text('Star Wars', style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(170,80,0,0),
                                child: Text('The Rise of Skywalker'),
                              ),
                            ],
                          ),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Fragment2(storyTitle: "Star Wars")));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
        ),
      ),
      //color: Colors.blue[600],
      height: 200,
      child: Padding(
        padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10 * SizeConfig.heightMultiplier),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 11 * SizeConfig.heightMultiplier,
                  width: 22 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          //image: AssetImage("")
                          image: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg")
                      )
                  ),
                ),
                SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Neil Sullivan Paul", style: TextStyle(
                        color: Colors.white,
                        fontSize: 3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Protorix", style: TextStyle(
                              color: Colors.white60,
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 3 * SizeConfig.heightMultiplier,),
          ],
        ),
      ),
    );
  }
}

class NotificationCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


/*class ContainerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w =size.width - 125;
    return Container(
      constraints: BoxConstraints.expand(
        height: 200.0,
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [Color.fromARGB(255, 69,104,220),Color.fromARGB(255, 176,106,179)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
        ),
      ),
      child: Container(
        //padding: EdgeInsets.fromLTRB(10, 50, w, 10),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                backgroundColor: Colors.black,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 85, 0, 10),
                  child: Text(
                    "sdgsdgsdgsdgD",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                *//*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    "D",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),*//*
              ],
            ),
          ],
        )
      ),
    );
  }
}*/

/*class Fragment1 extends StatefulWidget {
  @override
  _Fragment1State createState() => _Fragment1State();
}

class _Fragment1State extends State<Fragment1> with AutomaticKeepAliveClientMixin {

  var serverText = "";
  var roomText = "dfkhjbosdifjgolshidkjhikdf";
  var subjectText = "";
  var nameText = "";
  var emailText = "";
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      *//*backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Story"),
      ),*//*
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){

          *//*return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    //'Index number = ${index + 1}',
                    'Story Title ${index + 1}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Story description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );*//*

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: new InkWell(
                onTap: () {
                  String storyTitle = 'Story Title ${index + 1}';
                  _joinMeeting(storyTitle);
                },
                child: Column(
                  children: <Widget>[
                    Text(
                    //'Index number = ${index + 1}',
                    'Story Title ${index + 1}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                    height: 10,
                    ),
                    Text(
                    'Story description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                 ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _Base64(String s) {
    String credentials = s;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    String replaced = encoded.replaceAll(RegExp('='), '');
    return replaced;
  }

  _joinMeeting(String storyTitle) async {
    String serverUrl =
    serverText.trim()?.isEmpty ?? "" ? null : serverText;
    String encoded = _Base64(storyTitle);
    roomText = encoded;
    subjectText = storyTitle;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
        //FeatureFlagEnum.MEETING_NAME_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText
        ..serverURL = serverUrl
        ..subject = subjectText
        ..userDisplayName = nameText
        ..userEmail = emailText
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
  customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
          .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}*/