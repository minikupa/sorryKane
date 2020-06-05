import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Model/KaneType.dart';
import 'Model/LocationType.dart';
import 'widget/BottomBar.dart';
import 'widget/Hanwha.dart';
import 'widget/Tajiri.dart';

import 'widget/Kane.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<KaneState> _kaneKey = GlobalKey<KaneState>();
  GlobalKey<TajiriState> _tajiriKey = GlobalKey<TajiriState>();
  GlobalKey<HanwhaState> _hanwhaKey = GlobalKey<HanwhaState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(1750),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                "assets/background.webp",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )),
              Kane(
                key: _kaneKey,
              ),
              Hanwha(
                key: _hanwhaKey,
              ),
              Tajiri(
                key: _tajiriKey,
              ),
              Align(
                alignment: Alignment(-1.0, 1.0),
                child: Image.asset(
                  "assets/mushroom.webp",
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                        child: Image.asset(
                          "assets/tgd.webp",
                          width: 20,
                        ),
                        onTap: () => _launchURL("https://tgd.kr/kanetv8")),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        child: Image.asset(
                          "assets/copyright.webp",
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
          ),
        ),
        Expanded(
          child: BottomBar(_changeKane, _onOffLocation),
        )
      ],
    ));
  }

  _changeKane(KaneType kaneType) {
    _kaneKey.currentState.changeKane(kaneType);
  }

  _onOffLocation(LocationType locationType) {
    switch (locationType) {
      case LocationType.Tajiri:
        _tajiriKey.currentState.onOffLocation();
        break;
      case LocationType.Kimsungkeun:
        _hanwhaKey.currentState.onOffLocation();
        break;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
