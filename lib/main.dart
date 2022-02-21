import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  final playerState = FlutterRadioPlayer.flutter_radio_paused;


  const MyApp({Key? key}) : super(key: key);


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int _currentIndex = 0;
  double volume = 0.8;
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  @override
  void initState() {
    super.initState();
    initRadioService();
  }



  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
        "Flutter Radio Example",
        "Live",
        "http://radio.ukr.radio:8000/tysafm-mp3-m",
        "false",
      );
    } on PlatformException {
      if (kDebugMode) {
        print("Exception occurred while trying to register the services.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: const Text('Tysa FM',
              style: TextStyle(
                fontSize: 35,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10.0),

            color: Colors.teal,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url =
                                    'https://www.facebook.com/suspilne.tysafm/';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url = 'https://twitter.com/suspilne_tysafm';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url = 'https://www.instagram.com/suspilne.tysafm/';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Image(image: AssetImage('assets/images/TysaFM.png')),
                  StreamBuilder(
                    stream: _flutterRadioPlayer.isPlayingStream,
                    initialData: widget.playerState,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      String returnData = snapshot.data;
                      if (kDebugMode) {
                        print("object data: " + returnData);
                      }
                      switch (returnData) {

                        // break;
                        case FlutterRadioPlayer.flutter_radio_loading:
                          return const SizedBox(
                            width: 250,
                            height: 200,
                            child: Text(
                              "Завантаження...",textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          );
                        case FlutterRadioPlayer.flutter_radio_error:

                        //break;
                        default:
                          return SizedBox(
                            width: 250,
                            height: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                  iconSize: 100,
                                  onPressed: () async {
                                    if (kDebugMode) {
                                      print("button press data: " +
                                          snapshot.data.toString());
                                    }
                                    await _flutterRadioPlayer.playOrPause();
                                  },
                                  icon: snapshot.data ==
                                          FlutterRadioPlayer
                                              .flutter_radio_playing
                                      ? const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        )
                                      : const Icon(Icons.play_arrow,
                                          color: Colors.white),
                                ),
                                IconButton(
                                  iconSize: 100,
                                  onPressed: () async {
                                    _flutterRadioPlayer.setUrl(
                                      "http://radio.ukr.radio:8000/tysafm-mp3-m",
                                      "false",
                                    );
                                  },
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.white),
                                ),
                                // IconButton(
                                //onPressed: () async {
                                //  await _flutterRadioPlayer.stop();
                                // },
                                //  icon: const Icon(Icons.stop),
                                //  )
                              ],
                            ),
                          );
                        //break;
                      }
                    },
                  ),
                  // Slider(
                  //   value: volume,
                  //   min: 0,
                  //   max: 1.0,
                  //   onChanged: (value) => setState(
                  //         () {
                  //       volume = value;
                  //       _flutterRadioPlayer.setVolume(volume);
                  //     },
                  //   ),
                  // ),
                  // Text(
                  //   "Гучність " + (volume * 100).toStringAsFixed(0),
                  // ),

                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url =
                                    'http://t.me/suspilne_tysafm';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  Icons.telegram,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url = 'https://www.mixcloud.com/tysafm/';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  FontAwesomeIcons.mixcloud,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url =
                                    'http://twitch.tv/tysafm';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  Icons.connected_tv,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () async {
                                const url = 'tel:+38095 510 2277';

                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(
                                  Icons.phone_forwarded,
                                  color: Colors.white,
                                  size: 40
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




