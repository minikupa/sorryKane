import 'package:flutter/material.dart';
import 'package:kane/widget/DeployAbstract.dart';
import 'package:video_player/video_player.dart';

class Hanwha extends StatefulWidget {
  Hanwha({Key key}) : super(key: key);

  @override
  HanwhaState createState() => HanwhaState();
}

class HanwhaState extends State<Hanwha> implements DeployAbstract {
  bool isOn = true;

  VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/video/hanwha.mp4")
      ..addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          _stopVideo();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isOn
        ? Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(1.0, -0.7),
                child: InkWell(
                  child: Image.asset(
                    "assets/deploy/kimsungkeun.webp",
                    width: 80,
                  ),
                  onTap: () async {
                    if (!_controller.value.isPlaying) {
                      _controller.initialize().then((_) {
                        setState(() {
                          _controller.play();
                        });
                      });
                    } else {
                      _stopVideo();
                    }
                  },
                ),
              ),
              _controller.value.isPlaying
                  ? Align(
                      alignment: Alignment(0.5, -0.6),
                      child: Container(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ))
                  : Container(),
            ],
          )
        : Container();
  }

  onOffLocation() {
    setState(() {
      isOn = !isOn;
      if (!isOn) {
        _stopVideo();
      }
    });
  }

  _stopVideo() {
    setState(() {
      if(_controller.value.isPlaying) {
        _controller.pause();
      }
    });
  }
}
