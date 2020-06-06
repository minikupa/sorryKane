import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Hanwha extends StatefulWidget {
  Hanwha({Key key}) : super(key: key);

  @override
  HanwhaState createState() => HanwhaState();
}

class HanwhaState extends State<Hanwha> {
  bool _isHanwhaHover = false;
  bool _isHanwhaPlay = false;
  bool _isPlaying = false;
  bool _isOn = true;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/hanwha.mp4")
      ..addListener(() {
        if (_isPlaying && !_controller.value.isPlaying && _isHanwhaPlay) {
          setState(() {
            _isHanwhaPlay = false;
          });
        }
        _isPlaying = _controller.value.isPlaying;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHanwhaPlay && _controller.value.isPlaying) {
      _controller.pause();
    }
    return _isOn
        ? Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0.95, -0.4),
                child: InkWell(
                  child: _isHanwhaHover
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[400], BlendMode.modulate),
                          child: Image.asset(
                            "assets/deploy/kimsungkeun.webp",
                            width: 80,
                          ),
                        )
                      : Image.asset(
                          "assets/deploy/kimsungkeun.webp",
                          width: 80,
                        ),
                  onTap: () {
                    if (!_isHanwhaPlay) {
                      setState(() {
                        _isHanwhaPlay = true;
                        _isHanwhaHover = false;
                        _controller
                            .initialize()
                            .then((_) => _controller.play());
                      });
                    } else {
                      setState(() {
                        _isHanwhaHover = false;
                        _controller.pause();
                      });
                    }
                  },
                  onTapDown: (_) => setState(() => _isHanwhaHover = true),
                  onTapCancel: () => setState(() => _isHanwhaHover = false),
                ),
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
