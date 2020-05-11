import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Hanwha extends StatefulWidget {
  @override
  _HanwhaState createState() => _HanwhaState();
}

class _HanwhaState extends State<Hanwha> {
  bool _isHanwhaHover = false;
  bool _isHanwhaPlay = false;
  bool _isPlaying = false;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/hanwha.mp4")
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
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0.95, -0.4),
          child: InkWell(
            child: _isHanwhaHover
                ? ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.grey[400], BlendMode.modulate),
                    child: Image.asset(
                      "assets/kimsungkeun.webp",
                      width: 80,
                    ),
                  )
                : Image.asset(
                    "assets/kimsungkeun.webp",
                    width: 80,
                  ),
            onTap: () {
              if (!_isHanwhaPlay) {
                setState(() {
                  _isHanwhaPlay = true;
                  _isHanwhaHover = false;
                  _controller.initialize().then((_) => _controller.play());
                });
              } else {
                setState(() => _isHanwhaHover = false);
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
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
