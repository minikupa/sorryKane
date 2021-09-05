import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/DeployType.dart';
import '../model/KaneType.dart';
import '../model/PlaceType.dart';
import '../widget/Benz.dart';
import '../widget/BottomBar.dart';
import '../widget/Hanwha.dart';
import '../widget/Kane.dart';
import '../widget/Mushroom.dart';
import '../widget/Facilities.dart';
import '../widget/Tajiri.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<TajiriState> _tajiriKey = GlobalKey<TajiriState>();
  GlobalKey<HanwhaState> _hanwhaKey = GlobalKey<HanwhaState>();
  GlobalKey<MushroomState> _mushroomKey = GlobalKey<MushroomState>();
  GlobalKey<BenzState> _benzKey = GlobalKey<BenzState>();

  AudioCache _cache = AudioCache();

  String _place = "background";
  List<KaneType> _kaneList = [KaneType.Kane];

  @override
  void initState() {
    if (Random().nextInt(3) == 0) {
      _cache.play('music/opening.mp3', volume: 0.7);
    }
    super.initState();
  }

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
                "assets/background/$_place.webp",
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
              Facilities(),
              Stack(
                children: List.generate(
                    _kaneList.length,
                    (index) => _kaneList[index] != null
                        ? Kane(
                            kaneType: _kaneList[index],
                            index: index,
                            deleteKane: _deleteKane,
                          )
                        : Container()),
              )
            ],
          ),
        ),
        Expanded(
          child: BottomBar(
              _changeKane, _changeBackground, _onOffDeploy, _clearKane),
        )
      ],
    ));
  }

  _changeKane(KaneType kaneType) {
    if(Random().nextBool()) {
      List effectSound = ["heuhehe", "nice", "reul", "see", "hanna", "ja"];
      _cache.play(
          'music/${effectSound[Random().nextInt(effectSound.length)]}.mp3',
          volume: 0.5);
    }
    setState(() => _kaneList.add(kaneType));
  }

  _deleteKane(int index) => setState(() => _kaneList.removeAt(index));

  _clearKane() => setState(() => _kaneList = []);

  _changeBackground(PlaceType placeType) {
    setState(() {
      switch (placeType) {
        case PlaceType.ChromaKey:
          _place = "background";
          break;
        case PlaceType.BaseBall:
          _place = "baseball_field";
          break;
        case PlaceType.Kof:
          _place = "kof";
          break;
        case PlaceType.Wwe:
          _place = "wwe";
          break;
        case PlaceType.Booth:
          _place = "booth";
          break;
        default:
          _place = "hall";
      }
    });
  }

  _onOffDeploy(DeployType deployType) {
    switch (deployType) {
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
    }
  }
}
