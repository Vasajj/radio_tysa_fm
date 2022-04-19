import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        ),
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
            Container(
              alignment: Alignment.center,
              child: IconButton(
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
            Container(
              alignment: Alignment.center,
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
                  size: 40,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
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
                    size: 40,
                  ),
                )),
            Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () async {
                    const url = 'http://t.me/suspilne_tysafm';

                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.telegram,
                      color: Colors.white, size: 40),
                )),
            Container(
              alignment: Alignment.center,
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
                  size: 40,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: IconButton(
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
            Container(
              alignment: Alignment.center,
              child: IconButton(
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
    );
  }
}
