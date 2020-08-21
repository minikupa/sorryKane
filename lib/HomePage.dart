import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/KaneType.dart';
import 'model/PlaceType.dart';
import 'widget/Benz.dart';
import 'widget/Mushroom.dart';
import 'model/DeployType.dart';
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

  PlaceType _placeType = PlaceType.ChromaKey;

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
                "assets/background/${_placeType == PlaceType.ChromaKey ? "background" : "baseball_field"}.webp",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )),
              Mushroom(
                key: _mushroomKey,
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
              ),
              Kane(
                key: _kaneKey,
              ),
            ],
          ),
        ),
        Expanded(
          child: BottomBar(_changeKane, _changeBackground, _onOffLocation),
        )
      ],
    ));
  }

  _changeKane(KaneType kaneType) {
    _kaneKey.currentState.changeKane(kaneType);
  }

  _changeBackground(PlaceType placeType) {
    setState(() => _placeType = placeType);
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
