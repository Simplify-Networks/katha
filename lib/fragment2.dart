import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'SizeConfig.dart';


class Fragment2 extends StatefulWidget {
  final String storyTitle;
  const Fragment2 ({ Key key, this.storyTitle }): super(key: key);

  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Fragment2> {

  List<String> _notes = List<String>();
  List<String> _notesForDisplay = List<String>();

  var serverText = "";
  var roomText = "dfkhjbosdifjgolshidkjhikdf";
  var subjectText = "";
  var nameText = "";
  var emailText = "";
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  void assignVariable() {
    for (var i = 1; i <= 10; i++) {
      _notes.add('Neil Sullivan Paul $i');
      _notesForDisplay.add('Neil Sullivan Paul $i');
    }
  }

  @override
  void initState() {
    assignVariable();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heigh = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
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
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:55.0),
                        child: Text(
                          "CONTACTS",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,45,10,0),
                        child:Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white24,
                          ),
                          height: 40,
                          child: Theme(
                            child: TextField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: '',
                                prefixIcon: IconTheme(
                                  data: new IconThemeData(color: Colors.white),
                                  child: new Icon(Icons.search),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0),
                                ),
                              ),
                              onChanged: (text){
                                text = text.toLowerCase();
                                setState(() {
                                  _notesForDisplay = _notes.where((note) {
                                    var noteTitle = note.toLowerCase();
                                    return noteTitle.contains(text);
                                  }).toList();
                                });
                              },
                            ),
                            data: Theme.of(context).copyWith(primaryColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _notesForDisplay.length,
              itemBuilder: (context,i){
                return Container(
                  constraints: BoxConstraints.expand(
                    height: 120.0,
                  ),
                  child: InkWell(
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,0,0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                backgroundColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,20,0,0),
                          child: Column(
                            children: <Widget>[
                              Text(_notesForDisplay[(i-1) < 0 ? 0 : i], style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,45,0,0),
                          child: Column(
                            children: <Widget>[
                              Text("Senoir Storyteller", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100,75,0,0),
                          child: Column(
                            children: <Widget>[
                              Text("AVAILABLE", style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,95,10,0),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width-50,45,0,0),
                          child: Icon(
                              Icons.call
                          ),
                        ),
                      ],
                    ),
                    onTap:(){
                      _joinMeeting(widget.storyTitle);
                    },
                  ),
                );
              },
            ),
          ),
        ],
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

    if(storyTitle != "")
    {
      String encoded = _Base64(storyTitle);
      roomText = encoded;
      subjectText = storyTitle;
    }
    else
    {
      String encoded = _Base64("General Meeting");
      roomText = encoded;
      subjectText = "General Meeting";
    }


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
}

/*class Fragment2 extends StatefulWidget {
  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Fragment2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heigh = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
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
                    Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:50.0),
                            child: Text(
                              "Contacts",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Search...'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 4,
                  padding: EdgeInsets.fromLTRB(15,0,15,0),
                  itemBuilder: (context,i){
                    return Container(
                      constraints: BoxConstraints.expand(
                        height: 120.0,
                      ),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,35,0,0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                  backgroundColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,40,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Neil Sullivan Paul", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 3 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,70,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Protorix", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100,90,0,0),
                            child: Column(
                              children: <Widget>[
                                Text("Protorix", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,110,0,0),
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(width-80,60,0,0),
                            child: FlutterLogo(
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
