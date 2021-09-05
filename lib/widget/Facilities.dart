import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Facilities extends StatefulWidget {
  Facilities({Key key}) : super(key: key);

  @override
  FacilitiesState createState() => FacilitiesState();
}

class FacilitiesState extends State<Facilities> with WidgetsBindingObserver {
  bool _isBgmOn = false;

  AudioCache _cache = AudioCache();
  AudioPlayer _player;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isBgmOn) {
      _turnOnOffBgm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              InkWell(
                child:
                    _isBgmOn ? Icon(Icons.music_note) : Icon(Icons.music_off),
                onTap: () => _turnOnOffBgm(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                  child: Image.asset(
                    "assets/deploy/tgd.webp",
                    width: 20,
                  ),
                  onTap: () => _launchURL("https://tgd.kr/kanetv8"),
                ),
              ),
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
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _turnOnOffBgm() async {
    _isBgmOn = !_isBgmOn;
    if (_isBgmOn) {
      await _playBgm();
      _player.onPlayerCompletion.listen((event) {
        _playBgm();
      });
    } else {
      _player.stop();
    }
    setState(() {});
  }

  _playBgm() async {
    List bgmList = [
      "temple",
      "coningcity",
      "badguy",
      "arcade",
      "aquarium",
      "korbis",
      "kaded"
    ];
    int random = Random().nextInt(bgmList.length);
    _player =
        await _cache.play('music/bgm/${bgmList[random]}.mp3', volume: 0.25);
  }
}
