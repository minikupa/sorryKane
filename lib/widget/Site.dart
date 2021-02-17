import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Site extends StatefulWidget {
  Site({Key key}) : super(key: key);

  @override
  SiteState createState() => SiteState();
}

class SiteState extends State<Site> {
  bool _isOn = true;

  @override
  Widget build(BuildContext context) {
    return _isOn
        ? Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                        child: Image.asset(
                          "assets/deploy/tgd.webp",
                          width: 20,
                        ),
                        onTap: () =>  _launchURL("https://tgd.kr/kanetv8")),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        child: Image.asset(
                          "assets/deploy/copyright.webp",
                          width: 20,
                        ),
                        onTap: () => _launchURL("https://minikupa.com/142"),
                      ),
                    )
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              )
            ],
          )
        : Container();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  onOffLocation() {
    setState(() => _isOn = !_isOn);
  }
}
