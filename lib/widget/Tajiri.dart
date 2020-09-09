import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Tajiri extends StatefulWidget {
  Tajiri({Key key}) : super(key: key);

  @override
  TajiriState createState() => TajiriState();
}

class TajiriState extends State<Tajiri> with TickerProviderStateMixin {
  bool _isTajiriPlay = false;
  bool _isPlaying = false;
  bool _isOn = true;

  VideoPlayerController _controller;
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller = VideoPlayerController.asset("assets/video/tajiri.mp4")
      ..addListener(() {
        if (_isPlaying && !_controller.value.isPlaying && _isTajiriPlay) {
          setState(() {
            _isTajiriPlay = false;
            rotationController.reset();
          });
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
                duration: Duration(milliseconds: 300),
                top: 265,
                left: _isTajiriPlay ? 0 : -120,
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.1, end: 0.0).animate(rotationController),
                  child: InkWell(
                    child: Image.asset(
                      "assets/deploy/tajiri.webp",
                      width: 200,
                    ),
                    onTap: ()  {
                      if (!_isTajiriPlay) {
                        _controller
                            .initialize()
                            .then((_) => _controller.play());
                        setState(() {
                          rotationController.forward();
                          _isTajiriPlay = true;
                        });
                      } else {
                        _controller.pause();
                      }
                    },
                  ),
                ),
                onEnd: () {
                  if (!_isTajiriPlay) {
                    _controller.pause();
                  }
                },
              ),
              Align(
                alignment: Alignment(0.2, -0.4),
                child: _isTajiriPlay
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
