import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:video_player/video_player.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isHover = false;
  bool _isHanwhaHover = false;

  bool _isHanwhaPlay = false;
  bool _isPlaying = false;

  int _count = 0;
  AudioCache player = AudioCache();
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
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1800 / 1.9, height: 1800);
    return Scaffold(
        body: Center(
      child: Container(
        height: ScreenUtil().setHeight(1800),
        width: ScreenUtil().setHeight(1800) / 1.9,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/kane.webp',
              height: ScreenUtil().setHeight(1800),
              width: ScreenUtil().setHeight(1800) / 1.9,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: ScreenUtil().setHeight(770),
              left: ScreenUtil().setHeight(330),
              child: InkWell(
                child: _isHover
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.grey[400], BlendMode.modulate),
                        child: Image.asset(
                          'assets/nose.webp',
                          width: ScreenUtil().setHeight(96),
                        ),
                      )
                    : Image.asset(
                        'assets/nose.webp',
                        width: ScreenUtil().setHeight(96),
                      ),
                onTap: () {
                  setState(() => _isHover = false);
                  if (++_count >= Random().nextInt(5) + 2) {
                    _count = 0;
                    player.play('igonan.m4a');
                  } else {
                    player.play('bbolong.mp3');
                  }
                },
                onTapDown: (_) => setState(() => _isHover = true),
                onTapCancel: () => setState(() => _isHover = false),
              ),
            ),
            Align(
              alignment: Alignment(0.95, -0.8),
              child: InkWell(
                child: _isHanwhaHover
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.grey[400], BlendMode.modulate),
                        child: Image.asset(
                          'assets/kimsungkeun.webp',
                          width: ScreenUtil().setHeight(260),
                        ),
                      )
                    : Image.asset(
                        'assets/kimsungkeun.webp',
                        width: ScreenUtil().setHeight(260),
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
              alignment: Alignment(0.7, -0.8),
              child: _isHanwhaPlay
                  ? Container(
                      height: ScreenUtil().setHeight(250),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    ));
  }
}
