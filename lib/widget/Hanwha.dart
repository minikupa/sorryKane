import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Hanwha extends StatefulWidget {
  Hanwha({Key key}) : super(key: key);

  @override
  HanwhaState createState() => HanwhaState();
}

class HanwhaState extends State<Hanwha> {
  bool _isHanwhaPlay = false;
  bool _isPlaying = false;
  bool _isOn = true;

  VideoPlayerController _controller;

  @override
  void initState() {

    _controller = VideoPlayerController.asset("assets/video/hanwha.mp4")
      ..addListener(() {
        if (_isPlaying && !_controller.value.isPlaying && _isHanwhaPlay) {
          setState(() => _isHanwhaPlay = false);
        }
        _isPlaying = _controller.value.isPlaying;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isOn
        ? Stack(
            children: <Widget>[
              AnimatedPositioned(
                right: 0,
                top: _isHanwhaPlay ? 100 : 100.1,
                duration: Duration(milliseconds: 10),
                child: InkWell(
                  child: Image.asset(
                    "assets/deploy/kimsungkeun.webp",
                    width: 80,
                  ),
                  onTap: () {
                    if (!_isHanwhaPlay) {
                      _controller
                          .initialize()
                          .then((_) => _controller.play());
                      setState(() => _isHanwhaPlay = true);
                    } else {
                      _controller.pause();
                    }
                  },
                ),
                onEnd: () {
                  if (!_isHanwhaPlay && _controller.value.isPlaying) {
                    _controller.pause();
                  }
                },
              ),
              Align(
                alignment: Alignment(0.5, -0.6),
                child: _isHanwhaPlay
                    ? Container(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : Container(),
              )
            ],
          )
        : Container();
  }

  onOffLocation() {
    setState(() {
      _isOn = !_isOn;
      if (!_isOn) {
        _controller.pause();
      }
    });
  }
}
