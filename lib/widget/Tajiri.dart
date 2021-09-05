import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:kane/widget/DeployAbstract.dart';
import 'package:video_player/video_player.dart';

class Tajiri extends StatefulWidget {
  Tajiri({Key key}) : super(key: key);

  @override
  TajiriState createState() => TajiriState();
}

class TajiriState extends State<Tajiri>
    with TickerProviderStateMixin
    implements DeployAbstract {
  bool isOn = true;

  VideoPlayerController _controller;
  AnimationController _rotationController;

  @override
  void initState() {
    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller = VideoPlayerController.asset("assets/video/tajiri.mp4")
      ..addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          _stopTajiri();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return isOn
        ? Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                top: ScreenUtil().setHeight(250),
                left: _controller.value.isPlaying ? 0 : -120,
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.1, end: 0.0).animate(_rotationController),
                  child: InkWell(
                    child: Image.asset(
                      "assets/deploy/tajiri.webp",
                      width: 200,
                    ),
                    onTap: () {
                      if (!_controller.value.isPlaying) {
                        _controller.initialize().then((_) {
                          setState(() {
                            _controller.play();
                            _rotationController.forward();
                          });
                        });
                      } else {
                        _stopTajiri();
                      }
                    },
                  ),
                ),
                onEnd: () {
                  if (!_controller.value.isPlaying) {
                    _stopTajiri();
                  }
                },
              ),
              Align(
                alignment: Alignment(0.2, -0.4),
                child: _controller.value.isPlaying
                    ? Container(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
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
      isOn = !isOn;
      if (!isOn) {
        _stopTajiri();
      }
    });
  }

  _stopTajiri() {
    setState(() {
      if(_controller.value.isPlaying){
        _controller.pause();
      }
      _rotationController.reset();
    });
  }
}
