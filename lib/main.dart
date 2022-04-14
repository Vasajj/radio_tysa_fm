import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    initRadioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Tysa FM',
      url: 'http://radio.ukr.radio:8000/tysafm-mp3',
      imagePath: 'assets/Tysa.jpg',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Drawer(
          backgroundColor: const Color(0xff00310b),
          elevation: 20.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                backgroundImage: AssetImage('assets/TysaAvatar.jpg'),
                radius: 32,
              ),
              ListTile(
                leading: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () async {
                    const url = 'https://www.facebook.com/suspilne.tysafm/';
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              ListTile(
                leading: IconButton(
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
                    size: 40,
                  ),
                ),
              ),
              ListTile(
                  leading: IconButton(
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
                  size: 40,
                ),
              )),
              ListTile(
                  leading: IconButton(
                onPressed: () async {
                  const url = 'http://t.me/suspilne_tysafm';

                  if (await canLaunch(url)) {
                    await launch(url, forceSafariVC: false);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: const Icon(FontAwesomeIcons.telegramPlane,
                    color: Colors.white, size: 40),
              )),
              ListTile(
                leading: IconButton(
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
                    size: 40,
                  ),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () async {
                    const url = 'http://twitch.tv/tysafm';

                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(Icons.connected_tv,
                      color: Colors.white, size: 40),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () async {
                    const url = 'tel:+38095 510 2277';

                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(Icons.phone_forwarded,
                      color: Colors.white, size: 40),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff00310b),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
        title: const Text(
          'Tysa FM',
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1.0,
        // padding: const EdgeInsets.only(bottom: 1.0),
        color: const Color(0xff00310b),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Image(image: AssetImage('assets/Tysa.jpg')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .animate(_animationController),
                    child: IconButton(
                      iconSize: 100,
                      onPressed: () async {
                        setState(() {
                          _animationController.forward(from: 0.0);
                        });
                        _radioPlayer.stop();
                      },
                      icon: const Icon(FontAwesomeIcons.compactDisc,
                          color: Colors.white),
                    ),
                  ),
                  IconButton(
                    iconSize: 100,
                    onPressed: () async {
                      isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                    },
                    icon: Icon(
                        isPlaying
                            ? FontAwesomeIcons.pause
                            : FontAwesomeIcons.play,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
