import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kane/widget/Benz.dart';
import 'package:kane/widget/Mushroom.dart';
import 'Model/KaneType.dart';
import 'Model/DeployType.dart';
import 'widget/BottomBar.dart';
import 'widget/Hanwha.dart';
import 'widget/Tajiri.dart';
import 'widget/Site.dart';
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
  GlobalKey<MushroomState> _mushroomKey = GlobalKey<MushroomState>();
  GlobalKey<BenzState> _benzKey = GlobalKey<BenzState>();
  GlobalKey<SiteState> _siteKey = GlobalKey<SiteState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(1600),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                "assets/background.webp",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )),
              Mushroom(
                key: _mushroomKey,
              ),
              Kane(
                key: _kaneKey,
              ),
              Hanwha(
                key: _hanwhaKey,
              ),
              Tajiri(
                key: _tajiriKey,
              ),
              Benz(
                key: _benzKey,
              ),
              Site(
                key: _siteKey,
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

  _onOffLocation(DeployType locationType) {
    switch (locationType) {
      case DeployType.Tajiri:
        _tajiriKey.currentState.onOffLocation();
        break;
      case DeployType.Kimsungkeun:
        _hanwhaKey.currentState.onOffLocation();
        break;
      case DeployType.Mushroom:
        _mushroomKey.currentState.onOffLocation();
        break;
      case DeployType.Benz:
        _benzKey.currentState.onOffLocation();
        break;
      case DeployType.Site:
        _siteKey.currentState.onOffLocation();
        break;
    }
  }
}
