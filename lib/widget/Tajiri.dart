import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Tajiri extends StatefulWidget {
  @override
  _TajiriState createState() => _TajiriState();
}

class _TajiriState extends State<Tajiri> with TickerProviderStateMixin {
  double _leftPositioned = -120;
  AnimationController rotationController;

  bool _isTajiriPlay = false;
  bool _isPlaying = false;
  VideoPlayerController _controller;

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
            _leftPositioned = -120;
          });
        }
        _isPlaying = _controller.value.isPlaying;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          top: 240,
          left: _leftPositioned,
          child: RotationTransition(
            turns: Tween(begin: 0.1, end: 0.0).animate(rotationController),
            child: InkWell(
              child: Image.asset(
                "assets/tajiri.webp",
                width: 200,
              ),
              onTap: () {
                if (!_isTajiriPlay) {
                  setState(() {
                    _leftPositioned = 0;
                    rotationController.forward();
                    _isTajiriPlay = true;
                    _controller.initialize().then((_) => _controller.play());
                  });
                } else {
                  _controller.pause();
                }
              },
            ),
          ),
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
    );
  }
}
